select v.patient_id                                                           as PatientPK,
       v.uuid                                                                 as uuid,
       s.siteCode                                                             as SiteCode,
       0                                                                      AS FacilityId,
       de.unique_patient_no                                                   as PatientID,
       'KenyaEMR'                                                             as Emr,
       'Kenya HMIS II'                                                        as Project,
       s.FacilityName                                                         as FacilityName,
       v.visit_id                                                             as VisitID,
       v.visit_date                                                           as VisitDate,
       (case v.ipv when 1065 then 'Yes' when 1066 then 'No' end)              as IPV,
       (case v.physical_ipv when 158358 then 'Yes' when 1066 then 'No' end)   as PhysicalIPV,
       (case v.emotional_ipv when 118688 then 'Yes' when 1066 then 'No' end)  as EmotionalIPV,
       (case v.sexual_ipv when 152370 then 'Yes' when 1066 then 'No' end)     as SexualIPV,
       (case v.ipv_relationship when 1582 then 'Yes' when 1066 then 'No' end) as IPVRelationship,
       group_concat(case a.help_provider
                        when 1589 THEN "Hospital"
                        when 165284 then "Police"
                        when 165037 then "Peer Educator"
                        when 1560 then "Family"
                        when 165294 then "Peers"
                        when 5618 then "Friends"
                        when 165290 then "Religious Leader"
                        when 165350 then "Dice"
                        when 162690 then "Chief"
                        when 5622 then "Other"
                        end SEPARATOR '|')                                    as HelpProvider,
       group_concat(case a.action_taken
                        when 1066 then "No action taken"
                        when 165070 then "Counselling"
                        when 160570 then "Emergency pills"
                        when 1356 then "Hiv testing"
                        when 130719 then "Investigation done"
                        when 135914 then "Matter presented to court"
                        when 165228 then "P3 form issued"
                        when 165171 then "PEP given"
                        when 165192 then "Perpetrator arrested"
                        when 127910 then "Post rape care"
                        when 165203 then "PrEP given"
                        when 5618 then "Reconciliation"
                        when 165093 then "Referred back to the family"
                        when 165274 then "Referred to hospital"
                        when 165180 then "Statement taken"
                        when 165200 then "STI Prophylaxis"
                        when 165184 then "Trauma counselling done"
                        when 1185 then "Treatment"
                        when 5622 then "Other"
                        end SEPARATOR '|')                                    as ActionTaken,
       group_concat(a.action_date SEPARATOR '|')                              as ActionDate,
       group_concat(case a.reason_for_not_reporting
                        when 1067 then "Did not know where to report"
                        when 1811 then "Distance"
                        when 140923 then "Exhaustion/Lack of energy"
                        when 163473 then "Fear shame"
                        when 159418 then "Lack of faith in system"
                        when 162951 then "Lack of knowledge"
                        when 664 then "Negative attitude of the person reported to"
                        when 143100 then "Not allowed culturally"
                        when 165161 then "Perpetrator above the law"
                        when 163475 then "Self blame"
                        end SEPARATOR '|')                                    as RreasonForNotReporting,
       v.date_created                                                         as Date_Created,
       v.date_last_modified                                                   as Date_Last_Modified
from kenyaemr_etl.etl_gbv_screening v
         inner join kenyaemr_etl.etl_gbv_screening_action a
                    on v.patient_id = a.patient_id and v.encounter_id = a.encounter_id
         inner join kenyaemr_etl.etl_patient_demographics de on v.patient_id = de.patient_id
         inner join (select e.patient_id, max(e.visit_date) as latest_enrolment_date
                     from kenyaemr_etl.etl_hiv_enrollment e
                     group by e.patient_id) e on e.patient_id = v.patient_id
         left join (select d.patient_id as                                                           disc_patient,
                           coalesce(max(date(d.effective_discontinuation_date)), date(d.visit_date)) Outcome_date
                    from kenyaemr_etl.etl_patient_program_discontinuation d
                    where program_name = 'HIV'
                    group by d.patient_id) d on d.disc_patient = v.patient_id
         join kenyaemr_etl.etl_default_facility_info s
where d.disc_patient is null
   or d.Outcome_date < e.latest_enrolment_date
group by v.patient_id, v.encounter_id;