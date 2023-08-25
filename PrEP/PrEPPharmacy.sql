select d.patient_id                as PatientPK,
       f.uuid                      as uuid,
       i.siteCode                  as SiteCode,
       d.unique_prep_number        as PrEPNumber,
       d.openmrs_id                as HtsNumber,
       0                           as FacilityID,
       'KenyaEMR'                  as Emr,
       'HMIS'                      as Project,
       f.visit_id                  as VisitID,
       f.regimen_prescribed        as RegimenPrescribed,
       f.visit_date                as DispenseDate,
       f.months_prescribed_regimen as Duration,
       f.date_created              as DateCreated,
       f.date_last_modified        as DateModified,
       f.voided                    as voided
from dwapi_etl.etl_prep_followup f
         join dwapi_etl.etl_patient_demographics d on d.patient_id = f.patient_id
         join kenyaemr_etl.etl_default_facility_info i
where f.prescribed_PrEP = 'Yes';