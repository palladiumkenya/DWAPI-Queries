select d.patient_id                                                                      PatientPK,
       i.siteCode                                                                        SiteCode,
       d.openmrs_id                                                                      PatientMNCH_ID,
       'KenyaEMR'                                                                        Emr,
       'Kenya HMIS II'                                                                   Project,
       i.facilityName                                                                    FacilityName,
       l.visit_id                                                                        VisitId,
       l.visit_date                                                                      VisitDate,
       l.admission_number                                                                AdmissionNumber,
       ''                                                                                ANCVisits,
       l.date_of_delivery                                                                DateOfDelivery,
       l.duration_of_labor                                                               DurationOfLabor,
       l.duration_of_pregnancy                                                           GestationAtBirth,
       case l.mode_of_delivery
         when 1170 then 'Normal delivery'
         when 1171 then 'CS'
         when 1172 then 'Breech'
         when 118159 then 'Assisted vaginal delivery' end                                ModeOfDelivery,
       case l.placenta_complete
         when 163455 then 'Yes'
         when 163456 then 'No' end                                                       PlacentaComplete,
       ''                                                                                UterotonicGiven,
       ''                                                                                VaginalExamination,
       ''                                                                                BloodLoss,
       l.blood_loss                                                                      BloodLossVisual,
       case l.condition_of_mother
         when 160429 then 'Alive'
         when 134612 then 'Dead' end                                                     ConditonAfterDelivery,
       ''                                                                                MaternalDeath,
       coalesce(case l.coded_delivery_complications
                  when 118744 then 'Eclampsia'
                  when 113195 then 'Ruptured Uterus'
                  when 115036 then 'Obstructed Labor'
                  when 228 then 'APH'
                  when 230 then 'PPH'
                  when 130 then 'Puerperal sepsis'
                  when 1067 then 'Uknown' end, l.other_delivery_complications)           DeliveryComplications,
       (case l.delivery_outcome
          when 159913 then 1
          when 159914 then 2
          when 159915 then 3 end)                                                        NoBabiesDelivered,
       ''                                                                             as BabyBirthNumber,
       l.baby_sex                                                                     as SexBaby,
       l.birth_weight                                                                 as BirthWeight,
       case l.baby_condition
         when 151849 then 'Live birth'
         when 159916 then 'Fresh still birth'
         when 135436 then 'Macerated still birth' end                                 as 'BirthOutcome',
       case l.birth_with_deformity
         when 155871 then 'Yes'
         when 1066 then 'No'
         when 1175 then 'N/A' end                                                     as 'BirthWithDeformity',
       case l.teo_given
         when 84893 then 'Yes'
         when 1066 then 'No'
         when 1175 then 'N/A' end                                                     as TetracyclineGiven,
       case l.bf_within_one_hour when 1065 then 'Yes' when 1066 then 'No' end         as InitiatedBF,
       l.apgar_score_1min                                                             as ApgarScore1,
       l.apgar_score_5min                                                             as ApgarScore5,
       l.apgar_score_10min                                                            as ApgarScore10,
       ''                                                                             as KangarooCare,
       ''                                                                             as ChlorhexidineAppliedOnCordStump,
       ''                                                                             as VitaminKGiven,
       case c.baby_status when 163016 then 'Alive' when 160432 then 'Dead' end        as StatusBabyDischarge,
       c.discharge_date                                                               as MotherDischargeDate,
       ''                                                                             as SyphilisTestResults,
       ''                                                                             as HIVStatusLastANC,
       if(l.final_test_result is not null, 'Yes', 'No'),
       case l.test_1_kit_name
         when 164960 then 'Determine'
         when 164961 then 'First Response'
         when 165351 then 'Dual Kit' end                                              as HIVTest_1,
       case l.test_1_result
         when 703 then 'Positive'
         when 664 then 'Negative'
         when 163611 then 'Invalid' end                                               as HIV_1Results,
       case l.test_2_kit_name
         when 164960 then 'Determine'
         when 164961 then 'First Response'
         when 165351 then 'Dual Kit' end                                              as HIVTest_2,
       case l.final_test_result
         when 703 then 'Positive'
         when 664 then 'Negative'
         when 1138 then 'Invalid' end                                                 as HIVTestFinalResult,
       ''                                                                             as ONARTANC,
       if(l.baby_nvp_dispensed = 80586 or l.baby_azt_dispensed = 160123, 'Yes', 'No') as BabyGivenProphylaxis,
       case l.prophylaxis_given
         when 105281 then 'Yes'
         when 1107 then 'No'
         else '' end                                                                  as MotherGivenCTX,
       case l.partner_hiv_tested when 1065 then 'Yes' when 1066 then 'No' end         as PartnerHIVTestingMAT,
       case l.partner_hiv_status
         when 703 then 'HIV Positive'
         when 664 then 'HIV Negative'
         when 1067 then 'Unknown' end                                                 as PartnerHIVStatusMAT,
       concat_ws('|', nullif(case l.counseling_on_infant_feeding when 1065 then 'Infant feeding' end, ''), ''),
       c.referred_from                                                                as ReferredFrom,
       c.referred_to                                                                  as ReferredTo,
       l.clinical_notes                                                               as ClinicalNotes,
       l.date_created                                                                    Date_Created,
       GREATEST(COALESCE(l.date_last_modified, e.date_last_modified, c.date_last_modified),
                COALESCE(l.date_last_modified, e.date_last_modified,
                         c.date_last_modified))                                       as Date_Last_Modified
from kenyaemr_etl.etl_patient_demographics d
       join kenyaemr_etl.etl_mchs_delivery l on d.patient_id = l.patient_id
       join kenyaemr_etl.etl_mchs_discharge c on d.patient_id = c.patient_id
       join kenyaemr_etl.etl_mch_enrollment e on d.patient_id = e.patient_id
       join kenyaemr_etl.etl_default_facility_info i
where l.visit_id is not null
group by l.visit_id;
