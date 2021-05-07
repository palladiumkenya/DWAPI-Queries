select d.patient_id                                                            PatientPK,
       i.siteCode                                                              SiteCode,
       d.openmrs_id                                                            PatientMNCH_ID,
       'KenyaEMR'                                                              Emr,
       'Kenya HMIS II'                                                         Project,
       i.facilityName                                                          FacilityName,
       l.visit_id                                                              VisitId,
       l.visit_date                                                            VisitDate,
       l.admission_number                                                      AdmissionNumber,
       ''                                                                      ANCVisits,
       l.date_of_delivery                                                      DateOfDelivery,
       l.duration_of_labor                                                     DurationOfLabor,
       l.duration_of_pregnancy                                                 GestationAtBirth,
       case l.mode_of_delivery
         when 1170 then 'Normal delivery'
         when 1171 then 'CS'
         when 1172 then 'Breech'
         when 118159 then 'Assisted vaginal delivery' end                      ModeOfDelivery,
       case l.placenta_complete
         when 163455 then 'Yes'
         when 163456 then 'No' end                                             PlacentaComplete,
       ''                                                                      UterotonicGiven,
       ''                                                                      VaginalExamination,
       ''                                                                      BloodLoss,
       l.blood_loss                                                            BloodLossVisual,
       case l.condition_of_mother
         when 160429 then 'Alive'
         when 134612 then 'Dead' end                                           ConditonAfterDelivery,
       ''                                                                      MaternalDeath,
       coalesce(case l.coded_delivery_complications
                  when 118744 then 'Eclampsia'
                  when 113195 then 'Ruptured Uterus'
                  when 115036 then 'Obstructed Labor'
                  when 228 then 'APH'
                  when 230 then 'PPH'
                  when 130 then 'Puerperal sepsis'
                  when 1067 then 'Uknown' end, l.other_delivery_complications) DeliveryComplications,
       (case l.delivery_outcome
          when 159913 then 1
          when 159914 then 2
          when 159915 then 3 end)                                              NoBabiesDelivered,
       l.date_created                                                          Date_Created,
       GREATEST(COALESCE(l.date_last_modified, e.date_last_modified, ci.date_last_modified),
                COALESCE(l.date_last_modified, e.date_last_modified,
                         ci.date_last_modified)) as                            Date_Last_Modified
from kenyaemr_etl.etl_patient_demographics d
       join kenyaemr_etl.etl_mchs_delivery l on d.patient_id = l.patient_id
       left join kenyaemr_etl.etl_allergy_chronic_illness ci on l.visit_id = ci.visit_id
       join kenyaemr_etl.etl_mch_enrollment e on d.patient_id = e.patient_id
       join kenyaemr_etl.etl_default_facility_info i
where l.visit_id is not null
group by l.visit_id;
