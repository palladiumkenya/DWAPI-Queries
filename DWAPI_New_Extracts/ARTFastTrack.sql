select a.patient_id                                                                           as PatientPK,
       s.siteCode                                                                             as SiteCode,
       de.unique_patient_no                                                                   as PatientID,
       a.uuid                                                                                 as uuid,
       'KenyaEMR'                                                                             as Emr,
       'Kenya HMIS III'                                                                       as Project,
       s.FacilityName                                                                         as FacilityName,
       case a.art_refill_model
           when 1744 then 'Fast Track'
           when 1555 then 'Community ART Distribution - HCW Led'
           when 5618 then 'Community ART Distribution - Peer Led'
           when 1537 then 'Facility ART Distribution Group' end                               as ARTRefillModel,
       a.visit_date                                                                           as VisitDate,
       case a.ctx_dispensed when 162229 then 'Yes' end                                        as CTXDispensed,
       case a.dapsone_dispensed when 74250 then 'Yes' end                                     as DapsoneDispensed,
       case a.condoms_distributed
           when 1065 then 'Yes'
           when 1066 then 'No' end                                                            as CondomsDistributed,
       case a.oral_contraceptives_dispensed when 780 then 'Yes' end                           as OralContraceptivesDispensed,
       a.doses_missed                                                                         as MissedDoses,
       case a.fatigue when 162626 then 'Yes' when 1066 then 'No' end                          as Fatigue,
       case a.cough when 143264 then 'Yes' when 1066 then 'No' end                            as Cough,
       case a.fever when 140238 then 'Yes' when 1066 then 'No' end                            as Fever,
       case a.rash when 512 then 'Yes' when 1066 then 'No' end                                as Rash,
       case a.nausea_vomiting when 5978 then 'Yes' when 1066 then 'No' end                    as NauseaOrVomiting,
       case a.genital_sore_discharge
           when 135462 then 'Yes'
           when 1066 then 'No'
           else null end                                                                      as GenitalSoreOrDischarge,
       case a.diarrhea when 142412 then 'Yes' when 1066 then 'No' end                         as Diarrhea,
       a.other_specific_symptoms                                                              as OtherSymptoms,
       case a.pregnant when 1065 then 'Yes' when 1066 then 'No' when 1067 then 'Not sure' end as PregnancyStatus,
       case a.family_planning_status
           when 965 then 'On Family Planning'
           when 160652 then 'Not using Family Planning'
           when 1360 then 'Wants Family Planning'
           end                                                                                as FPStatus,
       a.family_planning_method                                                               as FPMethod,
       a.reason_not_on_family_planning                                                        as ReasonNotOnFP,
       a.referred_to_clinic                                                                   as ReferredToClinic,
       a.return_visit_date                                                                    as ReturnVisitDate,
       a.date_created,
       a.date_last_modified,
       a.voided
from dwapi_etl.etl_art_fast_track a
         inner join dwapi_etl.etl_hiv_enrollment e on a.patient_id = e.patient_id
         inner join dwapi_etl.etl_patient_demographics de on a.patient_id = de.patient_id
         join kenyaemr_etl.etl_default_facility_info s;


