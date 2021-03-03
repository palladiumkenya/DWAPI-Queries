select v.patient_related_to as PatientPK,
  s.siteCode as SiteCode,
  de.unique_patient_no as PatientID,
  'KenyaEMR' as Emr,'HMIS' as Project,
  s.FacilityName as FacilityName,
       v.patient_id as PartnerPersonID,timestampdiff(YEAR,date(v.birth_date),current_date()) as ContactAge,v.sex as ContactSex,
       (case v.marital_status when 1057 then 'Single' when 5555 then 'Married Monogamous' when 159715 then 'Married Polygamous'
                              when 1058 then 'Divorced' when 1059 then 'Widowed' end)  as ContactMaritalStatus,
       (case v.relationship_type when 970 then 'Mother' when 971 then 'Father' when 972 then 'Sibling' when 1528 then 'Child' when 5617 then 'Spouse'
                                 when 163565 then 'Partner' when 162221 then 'Co-wife' when 157351 then 'Injectable drug user'end) as RelationshipWithPatient,'' as ScreenedForIpv,'' as IpvScreening,
       v.ipv_outcome as IPVScreeningOutcome,v.living_with_patient as CurrentlyLivingWithIndexClient,
       v.baseline_hiv_status as KnowledgeOfHivStatus, v.pns_approach as PnsApproach,
       v.date_created as Date_Created, v.date_last_modified as Date_Last_Modified
from kenyaemr_etl.etl_patient_contact v
       inner join kenyaemr_etl.etl_patient_demographics de on v.patient_related_to = de.patient_id
       inner join (select e.patient_id, max(e.visit_date) as latest_enrolment_date from kenyaemr_etl.etl_hiv_enrollment e group by e.patient_id)e on v.patient_related_to = e.patient_id
       left join (select d.patient_id as disc_patient,coalesce(max(date(d.effective_discontinuation_date)),date(d.visit_date)) Outcome_date from kenyaemr_etl.etl_patient_program_discontinuation d
                  where program_name='HIV' group by d.patient_id)d on d.disc_patient = v.patient_id
       join kenyaemr_etl.etl_default_facility_info s
where d.disc_patient is null or d.Outcome_date < e.latest_enrolment_date;