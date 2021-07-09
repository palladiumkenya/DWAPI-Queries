select d.patient_id            as PatientPK,
       i.siteCode              as SiteCode,
       'KenyaEMR'              as Emr,
       'Kenya HMIS II'         as Project,
       i.FacilityName          as FacilityName,
       d.openmrs_id            as PatientMNCH_ID,
       v.visit_date            as VisitDate,
       v.visit_id              as VisitID,
       round(v.height, 2)      as Height,
       round(v.weight, 2)      as Weight,
       round(v.temperature, 2) as Temp,
       v.pulse_rate            as PulseRate,
       v.respiratory_rate      as RespiratoryRate,
       v.oxygen_saturation     as OxygenSaturation,
       v.muac                  as MUAC,
       v.weight_category       as WeightCategory,
       v.stunted               as Stunted,
       v.infant_feeding        as InfantFeeding,
       v.medication_given      as MedicationGiven,
       v.tb_assessment         as TBAssessment,
       v.mnps_supplementation  as MNPsSupplementation,
       ''                      as Immunization,
       ''                      as ImmunizationGiven,
       ''                      as DangerSigns,
       v.milestones            as Milestones,
       v.vitaminA_given        as VitaminA,
       v.disability            as Disability,
       ''                      as ReceivedMosquitoNet,
       v.dewormed              as Dewormed,
       v.referred_from         as ReferredFrom,
       v.referred_to           as ReferredTo,
       ''                      as ReferralReasons,
       v.follow_up             as FollowUP,
       v.appointment_date      as NextAppointment,
       v.dna_pcr               as dnapcr,
       v.dna_pcr_date          as dnapcrdate
from kenyaemr_etl.etl_patient_demographics d
       inner join (select v.patient_id,
                          v.visit_date,
                          v.visit_id,
                          round(v.height, 2),
                          round(v.weight, 2),
                          round(t.temperature, 1),
                          t.pulse_rate,
                          t.respiratory_rate,
                          t.oxygen_saturation,
                          (case v.muac
                             when 160909 then 'Green'
                             when 160910 then 'Yellow'
                             when 127778 then 'Red'
                             else '' end)                                                       as muac,
                          case v.weight_category
                            when 123814 then 'Underweight(UW)'
                            when 126598 then 'Severely Underweight(SUW)'
                            when 114413 then 'Overweight(OW)'
                            when 115115 then 'Obese(O)'
                            when 1115 then 'Normal(N)' end                                      as weight_category,
                          case v.stunted when 164085 then 'Yes' when 1115 then 'No' end         as stunted,
                          case v.infant_feeding
                            when 5526 then 'Exclusive Breastfeeding(EBF)'
                            when 1595 then 'Exclusive Replacement(ERF)'
                            when 6046 then 'Mixed Feeding(MF)'
                            else 'Not Breastfeeding' end                                        as infant_feeding,
                          concat_ws('|', nullif(case v.azt_given when 'Yes' then 'AZT' when 'No' then '' end, ''),
                                    nullif(case v.nvp_given when 'Yes' then 'NVP' when 'No' then '' end, ''),
                                    nullif(case v.ctx_given when 'Yes' then 'CTX' when 'No' then '' end, ''),
                                    nullif(case v.multi_vitamin_given when 'Yes' then 'AZT' when 'No' then '' end,
                                           ''))                                                 as medication_given,
                          case v.tb_assessment_outcome
                            when 1660 then 'No TB Signs'
                            when 142177 then 'Presumed TB'
                            when 1661 then 'TB Confirmed'
                            when 1662 then 'TB Rx'
                            when 1679 then 'INH'
                            when 160737 then 'Not Done'
                            else '' end                                                         as tb_assessment,
                          case v.review_of_systems_developmental
                            when 1115 then 'Normal(N)'
                            when 6022 then 'Delayed(D)'
                            when 6025 then 'Regressed(R)' end                                   as milestones,
                          case v.vitaminA_given when 1065 then 'Yes' when 1066 then 'No' end    as vitaminA_given,
                          case v.disability when 1065 then 'Yes' when 1066 then 'No' end        as disability,
                          case v.deworming_drug when 79413 then 'Yes' when 70439 then 'Yes' end as dewormed,
                          case v.counselled_on
                            when 1914 then 'HIV'
                            when 1380 then 'Nutrition Services' end                             as follow_up,
                          case v.referred_from
                            when 1537 then 'Another Health Facility'
                            when 163488 then 'Community Unit'
                            when 1175 then 'N/A' end                                            as referred_from,
                          case v.referred_to
                            when 1537 then 'Another Health Facility'
                            when 163488 then 'Community Unit'
                            when 1175 then 'N/A' end                                            as referred_to,
                          v.next_appointment_date                                               as appointment_date,
                          case v.dna_pcr_result
                            when 1138 then 'Indeterminate'
                            when 664 then 'Negative'
                            when 703 then 'Positive'
                            when 1304 then 'Poor sample quality' end                            as dna_pcr,
                          v.dna_pcr_sample_date                                                 as dna_pcr_date,
                          v.MNPS_Supplementation                                                as mnps_supplementation,
                          v.date_created                                                        as Date_Created,
                          v.date_last_modified                                                  as Date_Last_Modified
                   from kenyaemr_etl.etl_hei_follow_up_visit v
                          left join kenyaemr_etl.etl_patient_triage t
                            on v.visit_id = t.visit_id and v.patient_id = t.patient_id)v on d.patient_id = v.patient_id
       join kenyaemr_etl.etl_default_facility_info i;