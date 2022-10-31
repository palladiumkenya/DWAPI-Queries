SELECT r.patient_id         as PatientPK,
       i.siteCode           as SiteCode,
       i.FacilityName       as FacilityName,
       'KenyaEMR'           as Emr,
       'Kenya HMIS III'     as Project,
       r.source_system_uuid as SourceSysUUID,
       r.risk_score         as RiskScore,
       r.risk_factors       as RiskFactors,
       r.description        as Description,
       r.evaluation_date    as EvaluationDate,
       r.date_created       as DateCreated,
       r.date_changed       as DateLastModified
FROM openmrs.kenyaemr_ml_patient_risk_score r
         inner join kenyaemr_etl.etl_patient_demographics d on d.patient_id = r.patient_id
         join kenyaemr_etl.etl_default_facility_info i;
