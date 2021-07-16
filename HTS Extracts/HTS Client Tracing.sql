SELECT ht.patient_id                                                     as PatientPK,
       (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
       (select siteCode from kenyaemr_etl.etl_default_facility_info)     as SiteCode,
       htsrl.tracing_type                                                as TracingType,
       htsrl.visit_date                                                  as TracingDate,
       'KenyaEMR'                                                        as Emr,
       'Kenya HMIS II'                                                   AS Project,
       id.identifier                                                     AS HtsNumber,
       htsrl.tracing_status                                              as TracingOutcome
FROM kenyaemr_etl.etl_hts_test ht
       INNER JOIN kenyaemr_etl.etl_hts_test t ON ht.patient_id = t.patient_id
       LEFT JOIN kenyaemr_etl.etl_hts_referral_and_linkage htsrl ON ht.patient_id = htsrl.patient_id
       LEFT JOIN location SN ON SN.location_id = htsrl.encounter_location
       LEFT JOIN location_attribute SC ON SC.location_id = htsrl.encounter_location AND SC.attribute_type_id = 1
       LEFT JOIN patient_identifier id ON id.patient_id = htsrl.patient_id AND id.identifier_type =
                                                                               (select patient_identifier_type_id
                                                                                from patient_identifier_type
                                                                                where name = 'OpenMRS ID')
WHERE SC.value_reference IS NOT NULL;