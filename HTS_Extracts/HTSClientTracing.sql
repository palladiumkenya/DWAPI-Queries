SELECT ht.patient_id                                                     as PatientPK,
       htsrl.uuid                                                        as uuid,
       (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
       (select siteCode from kenyaemr_etl.etl_default_facility_info)     as SiteCode,
       htsrl.tracing_type                                                as TracingType,
       htsrl.visit_date                                                  as TracingDate,
       'KenyaEMR'                                                        as Emr,
       'Kenya HMIS II'                                                   AS Project,
       d.openmrs_id                                                      AS HtsNumber,
       htsrl.tracing_status                                              as TracingOutcome,
       htsrl.date_created                                                as Date_Created,
       htsrl.date_last_modified                                          as Date_Last_Modified,
       htsrl.voided                                                      as voided
FROM dwapi_etl.etl_hts_test ht
         INNER JOIN dwapi_etl.etl_patient_demographics d ON ht.patient_id = d.patient_id
         INNER JOIN dwapi_etl.etl_hts_referral_and_linkage htsrl ON ht.patient_id = htsrl.patient_id
where ht.final_test_result = 'Positive'
  and ht.test_type = 2;