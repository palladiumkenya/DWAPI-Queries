select
'' AS SatelliteName,
  (select siteCode from kenyaemr_etl.etl_default_facility_info) as FacilityId,
d.unique_patient_no as PatientID,
d.patient_id as PatientPK,
  (select siteCode from kenyaemr_etl.etl_default_facility_info) as siteCode,
  (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
'' as ExitDescription,
/*disc.visit_date as ExitDate,
case
when disc.discontinuation_reason is not null then cn.name
else '' end as ExitReason,*/
 'KenyaEMR' as Emr,
 'Kenya HMIS II' as Project,
CAST(now() as Date) AS DateExtracted,
max(disc.visit_date) AS ExitDate,
mid(max(concat(disc.visit_date,case when disc.discontinuation_reason is not null then cn.name
else '' end  )),20) as ExitReason,
	disc.date_created,
	GREATEST(COALESCE(disc.date_last_modified, d.date_last_modified), COALESCE(d.date_last_modified, disc.date_last_modified)) as date_last_modified
from kenyaemr_etl.etl_patient_program_discontinuation disc
join kenyaemr_etl.etl_patient_demographics d on d.patient_id=disc.patient_id
left outer join concept_name cn on cn.concept_id=disc.discontinuation_reason  and cn.concept_name_type='FULLY_SPECIFIED'
and cn.locale='en'
where d.unique_patient_no is not null
group by PatientID
order by disc.visit_date ASC;