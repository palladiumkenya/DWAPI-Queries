select d.openmrs_id                                                                  PatientPK,
       a.uuid                                                                     as uuid,
       i.siteCode                                                                    SiteCode,
       d.unique_patient_no                                                           PatientID,
       'KenyaEMR'                                                                    Emr,
       'Kenya HMIS II'                                                               Project,
       i.facilityName                                                                FacilityName,
       a.visit_id                                                                    VisitId,
       a.visit_date                                                                  Covid19AssessmentDate,
       if(a.final_vaccination_status in (166192, 5585), 'Yes', 'No')              as ReceivedCOVID19Vaccine,
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
                then 'Other' end)                                                 as FirstDoseVaccineAdministered,
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
                then 'Other' end)                                                 as SecondDoseVaccineAdministered,
       (case a.final_vaccination_status
            when 166192 then 'Partially Vaccinated'
            when 5585 then 'Fully Vaccinated'
            else 'Not Vaccinated' end)                                            as VaccinationStatus,
       (case a.first_vaccination_verified when 164134 then 'Yes' else 'No' end)   as VaccineVerificationFirstDose,
       (case a.second_vaccination_verified when 164134 then 'Yes' else 'No' end)  as VaccineVerificationSecondDose,
       (case a.ever_received_booster
            when 1065 then 'Yes'
            when 1066 then 'No' end)                                              as BoosterGiven,
       (case a.booster_vaccine_taken
            when 166156 then 'Astrazeneca'
            when 166355 then 'Johnson and Johnson'
            when 166154 then 'Moderna'
            when 166155 then 'Pfizer'
            when 166157 then 'Sputnik'
            when 166379 then 'Sinopharm'
            when 1067 then 'Unknown'
            when 5622 then 'Other(Specify)' end)                                  as BoosterDose,
       a.date_taken_booster_vaccine                                               as BoosterDoseDate,
       a.booster_sequence                                                         as Sequence,
       (case a.ever_tested_covid_19_positive
            when 703 then 'Yes'
            when 664 then 'No'
            when 1067 then 'Unknown' end)                                         as COVID19TestResult,
       (case booster_dose_verified when 164134 then 'Yes' end)                    as BoosterDoseVerified,
       a.date_tested_positive                                                     as COVID19TestDate,
       (case a.symptomatic
            when 1068 then 'Symptomatic'
            when 165912 then 'Asymptomatic' END)                                  as Covid19Presentation,
       (case a.hospital_admission
            when 1065 then 'Yes'
            when 1066 then 'No' end)                                              as AdmissionStatus,
       a.admission_unit                                                           as AdmissionUnit,
       ''                                                                         as MissedAppointmentDueToCOVID19,
       ''                                                                         as COVID19PositiveSinceLasVisit,
       ''                                                                         as COVID19TestDateSinceLastVisit,
       ''                                                                         as PatientStatusSinceLastVisit,
       ''                                                                         as AdmissionStatusSinceLastVisit,
       ''                                                                         as AdmissionStartDate,
       ''                                                                         as AdmissionEndDate,
       ''                                                                         as AdmissionUnitSinceLastVisit,
       (case a.on_oxygen_supplement when 1065 then 'Yes' when 1066 then 'No' end) as SupplementalOxygenReceived,
       (case a.on_ventillator when 1065 then 'Yes' when 1066 then 'No' end)       as PatientVentilated,
       a.date_created                                                             as DateCreated,
       a.date_last_modified                                                       as DateModified
from dwapi_etl.etl_patient_demographics d
         join dwapi_etl.etl_covid19_assessment a on d.patient_id = a.patient_id
         join kenyaemr_etl.etl_default_facility_info i
group by a.visit_id;