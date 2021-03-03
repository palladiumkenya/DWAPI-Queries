select v.patient_id as PatientPK,s.siteCode as SiteCode,de.unique_patient_no as PatientID,0 AS FacilityId,'KenyaEMR' as Emr,'Kenya HMIS II' as Project,s.FacilityName as FacilityName,v.visit_date as VisitDate,
       case v.on_anti_tb_drugs when 1065 then 'Yes' when 1066 then 'No' end as OnTBDrugs,case v.on_ipt when 1065 then 'Yes' when 1066 then 'No' end as OnIPT, case v.ever_on_ipt when 1065 then 'Yes' when 1066 then 'No' end as EverOnIPT,
       '' as Cough,
       '' as Fever,
       '' as NoticeableWeightLoss,
       '' as NightSweats,
       '' as Lethargy,
       concat_ws('|',case v.spatum_smear_ordered when 1065 then 'Sputum smear' end, case v.chest_xray_ordered when 1065 then 'Chest Xray' end,
                 case v.genexpert_ordered when 1065 then 'GeneXpert' end) as ICFActionTaken,
       concat_ws('|',case v.spatum_smear_result when 703 then 'Positive' when 664 then 'Negative' end, case v.chest_xray_result when 1115 then 'Normal' when 152526 then 'Abnormal' end,
                 case v.genexpert_result when 162203 then 'Mycobacterium Tuberculosis detected with Rifampicin resistance' when 664 then 'Negative' when 162204 then 'Mycobacterium Tuberculosis detected without Rifampicin resistance'
                                         when 164104  then 'Mycobacterium Tuberculosis detected with indeterminate resistance'
                                         when 163611 then 'Invalid' when 1138 then 'Indeterminate' end) as TestResult,
       (case v.clinical_tb_diagnosis when 703 then 'Positive' when 664 then 'Negative' end) as TBClinicalDiagnosis,
       (case v.contact_invitation when 1065 then 'Yes' when 1066 then 'No' end) as ContactsInvited,
       (case v.evaluated_for_ipt when 1065 then 'Yes' when 1066 then 'No' end) as EvaluatedForIPT,
       (case started_anti_TB when 1065 then 'Yes' when 1066 then 'No' end) as StartAntiTBs,
       v.tb_rx_date as TBRxStartDate,
       (case v.tb_status when 1660 then 'No Signs' when 142177 then 'Presumed TB' when 1662 then 'TB Confirmed'
                         when 160737 then 'TB Screening not done' end) as TBScreening,
       '' as IPTClientWorkUp,
       v.date_created as Date_Created, v.date_last_modified as Date_Last_Modified
from kenyaemr_etl.etl_patient_hiv_followup v
       inner join kenyaemr_etl.etl_patient_demographics de on v.patient_id = de.patient_id
       inner join (select e.patient_id, max(e.visit_date) as latest_enrolment_date from kenyaemr_etl.etl_hiv_enrollment e group by e.patient_id)e on v.patient_id = e.patient_id
       left join (select d.patient_id as disc_patient,coalesce(max(date(d.effective_discontinuation_date)),date(d.visit_date)) Outcome_date from kenyaemr_etl.etl_patient_program_discontinuation d
                  where program_name='HIV' group by d.patient_id)d on d.disc_patient = v.patient_id
       join kenyaemr_etl.etl_default_facility_info s
where d.disc_patient is null or d.Outcome_date < e.latest_enrolment_date group by v.encounter_id;