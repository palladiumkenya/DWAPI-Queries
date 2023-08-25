select d.patient_id                        as PatientPK,
       f.uuid                              as uuid,
       i.siteCode                          as SiteCode,
       d.unique_prep_number                as PrEPNumber,
       d.openmrs_id                        as HtsNumber,
       'KenyaEMR'                          as Emr,
       'HMIS'                              as Project,
       f.visit_date                        as ExitDate,
       f.discontinue_reason                as ExitReason,
       CAST(f.last_prep_dose_date AS DATE) as DateOfLastPrepDose,
       f.date_created                      as DateCreated,
       f.date_last_modified                as DateLastModified,
       f.voided                            as voided
from dwapi_etl.etl_prep_discontinuation f
         join dwapi_etl.etl_patient_demographics d on d.patient_id = f.patient_id
         join kenyaemr_etl.etl_default_facility_info i;
