select distinct a.patient_id                                                      as PatientPK,
                (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
                (select siteCode from kenyaemr_etl.etl_default_facility_info)     as SiteCode,
                'KenyaEMR'                                                        as Emr,
                'Kenya HMIS II'                                                   AS Project,
                id.identifier                                                     AS HtsNumber,
                ref.date_to_enrol                                                 as DatePrefferedToBeEnrolled,
                ref.facility_referred_to                                          as FacilityReferredTo,
                a.provider_handed_to                                              as HandedOverTo,
                NULL                                                                 HandedOverToCadre,
                a.facility_linked_to                                              as EnrolledFacilityName,
                ref.visit_date                                                    as ReferralDate,
                a.enrollment_date                                                 as DateEnrolled,
                a.ccc_number                                                      as ReportedCCCNumber,
                a.art_start_date                                                  as ReportedStartARTDate
from (SELECT Distinct patient_id,
                      encounter_id,
                      ccc_number,
                      enrollment_date,
                      art_start_date,
                      provider_handed_to,
                      facility_linked_to,
                      encounter_location
      FROM (SELECT DISTINCT htsrl.patient_id,
                            encounter_id,
                            ccc_number,
                            enrollment_date,
                            art_start_date,
                            provider_handed_to,
                            facility_linked_to,
                            encounter_location
            FROM kenyaemr_etl.etl_hts_referral_and_linkage htsrl
            UNION ALL
            SELECT DISTINCT t.patient_id,
                            t.encounter_id,
                            unique_patient_no ccc_number,
                            e.visit_date      DateEnrolled,
                            ar.art_start_date,
                            provider_handed_to,
                            facility_linked_to,
                            t.encounter_location
            FROM kenyaemr_etl.etl_hts_test t
                   INNER JOIN kenyaemr_etl.etl_patient_demographics pt ON pt.patient_id = t.patient_id AND pt.voided = 0
                   INNER JOIN kenyaemr_etl.etl_hiv_enrollment e ON e.patient_id = t.patient_id AND e.voided = 0
                   LEFT JOIN kenyaemr_etl.etl_hts_referral_and_linkage l ON l.patient_id = t.patient_id
                   LEFT JOIN (SELECT patient_id, min(date_started) as art_start_date
                              FROM kenyaemr_etl.etl_drug_event
                              group by patient_id)ar on ar.patient_id = t.patient_id
            WHERE t.test_type = 1
              AND t.final_test_result = 'Positive'
              AND t.voided = 0
              AND l.patient_id IS NULL)a) a
       left join kenyaemr_etl.etl_hts_referral ref on a.patient_id = ref.patient_id
       LEFT JOIN location_attribute SC
         ON (SC.location_id = a.encounter_location or SC.location_id = ref.encounter_location) AND
            SC.attribute_type_id = 1
       LEFT JOIN location SN ON (SN.location_id = a.encounter_location or SN.location_id = ref.encounter_location)
       LEFT JOIN patient_identifier id ON (id.patient_id = a.patient_id or id.patient_id = ref.patient_id) AND
                                          id.identifier_type = (select patient_identifier_type_id
                                                                from patient_identifier_type
                                                                where name = 'OpenMRS ID')
       LEFT JOIN kenyaemr_etl.etl_hiv_enrollment EN ON EN.patient_id = a.patient_id
where a.patient_id in (select patient_id from kenyaemr_etl.etl_hts_test);