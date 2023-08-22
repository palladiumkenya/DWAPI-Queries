select a.patient_id           as PatientPK,
       a.uuid             as uuid,
       i.FacilityName         as FacilityName,
       i.siteCode             as SiteCode,
       'KenyaEMR'             as Emr,
       'Kenya HMIS II'        AS Project,
       HtsNumber              AS HtsNumber,
       ref.date_to_enrol      as DatePrefferedToBeEnrolled,
       a.facility_referred_to as FacilityReferredTo,
       a.provider_handed_to   as HandedOverTo,
       a.HandedOverToCadre       HandedOverToCadre,
       a.facility_linked_to   as EnrolledFacilityName,
       a.visit_date           as ReferralDate,
       a.enrollment_date      as DateEnrolled,
       a.ccc_number           as ReportedCCCNumber,
       a.art_start_date       as ReportedStartARTDate,
       a.date_created         as Date_Created,
       a.date_last_modified   as Date_Last_Modified,
       a.voided           as voided
from (SELECT Distinct patient_id,
                      uuid,
                      encounter_id,
                      visit_date,
                      ccc_number,
                      HtsNumber,
                      enrollment_date,
                      art_start_date,
                      provider_handed_to,
                      HandedOverToCadre as HandedOverToCadre,
                      facility_linked_to,
                      facility_referred_to,
                      encounter_location,
                      date_created,
                      date_last_modified,
                      voided
      FROM (SELECT DISTINCT htsrl.patient_id,
                            htsrl.uuid              as uuid,
                            encounter_id,
                            htsrl.visit_date,
                            ccc_number,
                            demo.openmrs_id            HtsNumber,
                            enrollment_date,
                            art_start_date,
                            provider_handed_to,
                            htsrl.cadre             as HandedOverToCadre,
                            facility_linked_to,
                            htsrl.referral_facility as facility_referred_to,
                            encounter_location,
                            htsrl.date_created,
                            htsrl.date_last_modified,
                            htsrl.voided            as voided
            FROM dwapi_etl.etl_hts_referral_and_linkage htsrl
                     inner join dwapi_etl.etl_patient_demographics demo
                                on demo.patient_id = htsrl.patient_id
            UNION ALL
            SELECT DISTINCT t.patient_id,
                            t.uuid as uuid,
                            t.encounter_id,
                            t.visit_date,
                            unique_patient_no            ccc_number,
                            pt.openmrs_id             as HtsNumber,
                            e.visit_date                 DateEnrolled,
                            ar.art_start_date,
                            l.provider_handed_to      as provider_handed_to,
                            l.cadre                   as HandedOverToCadre,
                            t.other_referral_facility as facility_referred_to,
                            l.facility_linked_to      as facility_linked_to,
                            t.encounter_location,
                            t.date_created,
                            t.date_last_modified,
                            t.voided as voided
            FROM dwapi_etl.etl_hts_test t
                     INNER JOIN dwapi_etl.etl_patient_demographics pt
                                ON pt.patient_id = t.patient_id /*AND pt.voided = 0*/
                     INNER JOIN dwapi_etl.etl_hiv_enrollment e ON e.patient_id = t.patient_id /*AND e.voided = 0*/
                     LEFT JOIN dwapi_etl.etl_hts_referral_and_linkage l ON l.patient_id = t.patient_id
                     LEFT JOIN (SELECT patient_id, min(date_started) as art_start_date
                                FROM dwapi_etl.etl_drug_event
                                group by patient_id) ar on ar.patient_id = t.patient_id
            WHERE t.test_type = 2
              AND t.final_test_result = 'Positive'
              AND t.referral_facility is not null
               /* AND t.voided = 0*/) a) a
         join kenyaemr_etl.etl_default_facility_info i
         left join dwapi_etl.etl_hts_referral ref on a.patient_id = ref.patient_id;