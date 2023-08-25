select d.patient_id                           PatientPK,
       s.uuid                              as uuid,
       i.siteCode                             SiteCode,
       d.unique_patient_no                    PatientID,
       0                                   as FacilityId,
       'KenyaEMR'                             Emr,
       'Kenya HMIS III'                       Project,
       i.facilityName                         FacilityName,
       s.visit_id                             VisitId,
       s.visit_date                           VisitDate,
       s.visit_type                        as VisitType,
       s.screening_method                  as ScreeningMethod,
       s.treatment_method                  as TreatmentToday,
       s.screening_type                    as ScreeningType,
       s.post_treatment_complication_cause as PostTreatmentComplicationCause,
       s.post_treatment_complication_other as OtherPostTreatmentComplication,
       s.screening_result                  as ScreeningResult,
       s.referred_out                      as ReferredOut,
       s.referral_reason                   as ReferralReason,
       date(s.next_appointment_date)       as NextAppointmentDate,
       s.date_created                      as DateCreated,
       s.date_last_modified                as DateModified,
       s.voided                            as voided
from dwapi_etl.etl_patient_demographics d
         join dwapi_etl.etl_cervical_cancer_screening s on d.patient_id = s.patient_id
         join kenyaemr_etl.etl_default_facility_info i
group by s.visit_id;
