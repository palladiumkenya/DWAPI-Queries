#Lab extracts for C&T
select ''                                                                               AS SatelliteName,
       0                                                                                AS FacilityId,
       d.unique_patient_no                                                              as PatientID,
       d.patient_id                                                                     as PatientPK,
       l.encounter_id                                                                   as VisitId,
       CAST(l.visit_date AS DATE)                                                       as OrderedByDate,
       CAST(l.visit_date AS DATE)                                                       as ReportedByDate,
       i.siteCode                                                                       as SiteCode,
       i.facilityName                                                                   as FacilityName,
       cn.name                                                                          as TestName,
       l.date_test_requested                                                            as DateSampleTaken,
       (case l.order_reason
            when 843 then 'Confirmation of treatment failure (repeat VL)'
            when 1434 then 'Pregnancy'
            when 162080 then 'Baseline VL (for infants diagnosed through EID)'
            when 1259 then 'Single Drug Substitution'
            when 159882 then 'Breastfeeding'
            when 163523 then 'Clinical failure'
            when 161236 then 'Routine'
            when 160032 then 'Confirmation of persistent low level Viremia (PLLV)' end) as Reason,
       case
           when c.datatype_id = 2 then cn2.name
           else
               l.test_result
           end                                                                          as TestResult,
       NULL                                                                             as EnrollmentTest,
       o.sample_type                                                                    as SampleType,
       'KenyaEMR'                                                                       as Emr,
       'Kenya HMIS II'                                                                  as Project,
       l.date_created                                                                   as Date_Created,
       l.date_last_modified                                                             as Date_Last_Modified
from kenyaemr_etl.etl_laboratory_extract l
         join kenyaemr_etl.etl_patient_demographics d on d.patient_id = l.patient_id
         join concept_name cn
              on cn.concept_id = l.lab_test and cn.concept_name_type = 'FULLY_SPECIFIED' and cn.locale = 'en'
         join concept c on c.concept_id = l.lab_test
         left join kenyaemr_order_entry_lab_manifest_order o on l.order_id = o.order_id
         join kenyaemr_etl.etl_default_facility_info i
         left outer join concept_name cn2
                         on cn2.concept_id = l.test_result and cn2.concept_name_type = 'FULLY_SPECIFIED'
                             and cn2.locale = 'en'
where d.unique_patient_no is not null
group by l.patient_id;