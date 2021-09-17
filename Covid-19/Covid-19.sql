select d.openmrs_id                                                                  PatientPK,
       i.siteCode                                                                    SiteCode,
       d.unique_patient_no                                                           PatientID,
       'KenyaEMR'                                                                    Emr,
       'Kenya HMIS II'                                                               Project,
       i.facilityName                                                                FacilityName,
       a.visit_id                                                                    VisitId,
       a.visit_date                                                                  Covid19AssessmentDate,
       if(a.final_vaccination_status in (66192, 5585), 'Yes', 'No')               as ReceivedCOVID19Vaccine,
       a.first_dose_date                                                          as DategivenFirstDose,
       (case a.first_vaccine_type
          when 166156 then 'Astrazeneca'
          when 166355 then 'Johnson and Johnson'
          when 166154 then 'Moderna'
          when 166155 then 'Pfizer'
          when 166157 then 'Sputnik'
          when 166379 then 'Sinopharm'
          when 1067 then 'Unknown'
          when 5622
                  then 'Other' end)                                               as FirstDoseVaccineAdministered,
       a.second_dose_date                                                         as DateGivenSecondDose,
       (case a.second_vaccine_type
          when 166156 then 'Astrazeneca'
          when 166355 then 'Johnson and Johnson'
          when 166154 then 'Moderna'
          when 166155 then 'Pfizer'
          when 166157 then 'Sputnik'
          when 166379 then 'Sinopharm'
          when 1067 then 'Unknown'
          when 5622
                  then 'Other' end)                                               as SecondDoseVaccineAdministered,
       (case a.final_vaccination_status
          when 166192 then 'Partially Vaccinated'
          when 5585 then 'Fully Vaccinated'
          else 'Not Vaccinated' end)                                              as VaccinationStatus,
       (case a.first_vaccination_verified when 164134 then 'Yes' else 'No' end)   as VaccineVerificationFirstDose,
       (case a.second_vaccination_verified when 164134 then 'Yes' else 'No' end)  as VaccineVerificationSecondDose,
       (case a.ever_received_booster
          when 1065 then 'Yes'
          when 1066 then 'No' end)                                                as BoosterGiven,
       (case a.booster_vaccine_taken
          when 166156 then 'Astrazeneca'
          when 166355 then 'Johnson and Johnson'
          when 166154 then 'Moderna'
          when 166155 then 'Pfizer'
          when 166157 then 'Sputnik'
          when 166379 then 'Sinopharm'
          when 1067 then 'Unknown'
          when 5622 then 'Other(Specify)' end)                                    as BoosterDose,
       a.date_taken_booster_vaccine                                               as BoosterDoseDate,
       a.booster_sequence                                                         as Sequence,
    -- (case booster_dose_verified when 164134 then 'Yes' end) as booster_dose_verified,
       (case a.ever_tested_covid_19_positive
          when 703 then 'Yes'
          when 664 then 'No'
          when 1067 then 'Unknown' end)                                           as COVID19TestResult,
       a.date_tested_positive_before_first_visit                                  as COVID19TestDate,
       (case a.symptomatic_before_first_visit
          when 1068 then 'Yes'
          when 165912 then 'No' END)                                              as PatientStatus,
       (case a.admitted_before_first_visit
          when 1065 then 'Yes'
          when 1066 then 'No' end)                                                as AdmissionStatus,
       a.admission_unit                                                           as AdmissionUnit,
       ''                                                                         as MissedAppointmentDueToCOVID19,
       ''                                                                         as AdmissionStartDate,
       ''                                                                         as AdmissionEndDate,
       (case a.on_oxygen_supplement when 1065 then 'Yes' when 1066 then 'No' end) as SupplementalOxygenReceived,
       (case a.on_ventillator when 1065 then 'Yes' when 1066 then 'No' end)       as PatientVentilated,
       t.tracing_outcome                                                          as TracingFinalOutcome,
       t.cause_of_death                                                           as CauseOfDeath,
       a.date_created                                                             as DateCreated,
       a.date_last_modified                                                       as DateModified
from kenyaemr_etl.etl_patient_demographics d
       join kenyaemr_etl.etl_covid19_assessment a on d.patient_id = a.patient_id
       left join kenyaemr_etl.etl_patient_program_discontinuation dis on a.patient_id = dis.patient_id
       left join (select t.patient_id,
                         case t.tracing_outcome
                           when 160432 then 'Dead'
                           when 1693 then 'Receiving ART from another clinic/Transferred'
                           when 5240 then 'Still in care at CCC'
                           when 164435 then 'Lost to follow up'
                           when 142917 then 'Stopped treatment'
                           /*when then 'COVID19 PositiveResult'*/ end as tracing_outcome,
                         case t.cause_of_death
                           when 162574 then 'Death related to HIV infection'
                           when '116030' then 'Cancer'
                           when 164500 then 'TB'
                           when 151522 then 'Other infectious and parasitic diseases'
                           when 133481 then 'Natural cause'
                           when 1603 then 'Unnatural Cause'
                           when 5622 then 'Uknown Cause' end      as cause_of_death
                  from kenyaemr_etl.etl_ccc_defaulter_tracing t)t on a.patient_id = t.patient_id
       join kenyaemr_etl.etl_default_facility_info i
group by a.visit_id;