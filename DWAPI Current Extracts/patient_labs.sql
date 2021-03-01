select distinct '' AS SatelliteName,
 (select siteCode from kenyaemr_etl.etl_default_facility_info) as FacilityId,
 d.unique_patient_no as patientID,
 d.patient_id as patientPK,
 l.encounter_id as visitID,
CAST(l.visit_date AS DATE) as orderedByDate,
 CAST(l.visit_date AS DATE) as reportedByDate,
 null as reason,
 (select siteCode from kenyaemr_etl.etl_default_facility_info) as  facilityID,
 (select siteCode from kenyaemr_etl.etl_default_facility_info) as  siteCode,
 (select FacilityName from kenyaemr_etl.etl_default_facility_info) as facilityName,
cn.name as testName,
case
when c.datatype_id=2 then cn2.name
else
 l.test_result
end as TestResult,
NULL as enrollmentTest,
 'KenyaEMR' as Emr,
 'Kenya HMIS II' as Project,
l.date_created,
GREATEST(COALESCE(l.date_last_modified, d.date_last_modified), COALESCE(d.date_last_modified, l.date_last_modified)) as date_last_modified
from kenyaemr_etl.etl_laboratory_extract l
join kenyaemr_etl.etl_patient_demographics d on d.patient_id=l.patient_id
join concept_name cn on cn.concept_id=l.lab_test and cn.concept_name_type='FULLY_SPECIFIED'and cn.locale='en'
join concept c on c.concept_id = l.lab_test
left outer join concept_name cn2 on cn2.concept_id=l.test_result and cn2.concept_name_type='FULLY_SPECIFIED'
and cn2.locale='en' where d.unique_patient_no is not null