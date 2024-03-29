select d.patient_id                     as PatientPK,
       r.uuid                           as UUID,
       i.siteCode                       as SiteCode,
       d.unique_prep_number             as PrepNumber,
       'KenyaEMR'                       as Emr,
       'Kenya HMIS III'                 as Project,
       r.visit_date                     as VisitDate,
       r.assessed_for_behavior_risk     as AssessedForBehaviorRisk,
       r.risk_for_hiv_positive_partner  as RiskForHIVPositivePartner,
       r.client_assessment              as ClientAssessment,
       r.adherence_assessment           as AdherenceAssessment,
       r.poor_adherence_reasons         as PoorAdherenceReasons,
       r.other_poor_adherence_reasons   as OtherPoorAdherenceReason,
       r.adherence_counselling_done     as AdherenceCounsellingDone,
       r.prep_status                    as PrepStatus,
       r.switching_option               as SwitchingOption,
       r.switching_date                 as SwitchingdDate,
       r.prep_type                      as PrepType,
       r.prescribed_prep_today          as PrescribedPrepToday,
       r.prescribed_regimen             as PrescribedRegimen,
       r.prescribed_regimen_months      as MonthsPrecribed,
       r.number_of_condoms_issued       as NumberOfCondomsIssued,
       r.prep_discontinue_reasons       as DiscontinueReason,
       r.prep_discontinue_other_reasons as OtherDiscontinueReason,
       r.appointment_given              as AppointmentGiven,
       r.next_appointment               as NextAppointment,
       r.remarks                        as Remarks,
       r.voided                         as Voided,
       r.date_created,
       r.date_last_modified
from dwapi_etl.etl_prep_monthly_refill r
         inner join dwapi_etl.etl_prep_enrolment e on r.patient_id = e.patient_id
         inner join dwapi_etl.etl_patient_demographics d on e.patient_id = d.patient_id
         join kenyaemr_etl.etl_default_facility_info i;