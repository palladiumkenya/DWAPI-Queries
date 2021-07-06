select d.patient_id                                                                 as PatientPK,
       i.siteCode                                                                   as SiteCode,
       d.openmrs_id                                                                 as PatientMNCHCWC_ID,
       'KenyaEMR'                                                                   as Emr,
       'Kenya HMIS II'                                                              as Project,
       i.FacilityName                                                               as FacilityName,
       (case m.service_type
          when 1622 then 'ANC'
          when 164835 then 'Delivery'
          when 1623 then 'PNC'
          else '' end)                                                              as ServiceType,
       coalesce(c.hei_enrolment_date, m.mch_enrollment_date)                        as EnrollmentDateATMNCH,
       m.anc_number                                                                 as MNCHNumber,
       m.first_anc_visit                                                            as FirstVisitANC,
       m.parity                                                                     as Parity,
       m.gravida                                                                    as Gravidae,
       m.lmp                                                                        as LMP,
       coalesce(m.edd, date_add(date_add(m.lmp, interval 7 day), interval 9 month)) as EDDFromLMP,
       (case m.hiv_status_before_anc
          when 664 then "Negative"
          when 703 then "Positive"
          when 1067 then "Unknown"
          else "" end)                                                              as HIVStatusBeforeANC,
       m.test_date                                                                  as HIVTestDate,
       (case m.partner_status
          when 664 then "Negative"
          when 703 then "Positive"
          when 1067 then "Unknown"
          else "" end)                                                              as PartnerHIVStatus,
       m.partner_test_date                                                          as PartnerHIVTestDate,
       (case m.blood_group
          when 690 then "A POSITIVE"
          when 692 then "A NEGATIVE"
          when 694 then "B POSITIVE"
          when 696 then "B NEGATIVE"
          when 699 then "O POSITIVE"
          when 701 then "O NEGATIVE"
          when 1230 then "AB POSITIVE"
          when 1231 then "AB NEGATIVE"
          else "" end)                                                              as BloodGroup,
       coalesce(m.status_in_mnch, c.status_in_cwc)                                  as StatusAtMNCH,
       m.date_created                                                               as Date_Created,
       m.date_last_modified                                                         as Date_Last_Modified
from kenyaemr_etl.etl_patient_demographics d
       left join (select m.patient_id,
                         m.service_type          as service_type,
                         m.visit_date            as mch_enrollment_date,
                         m.anc_number            as anc_number,
                         m.first_anc_visit_date  as first_anc_visit,
                         m.parity                as parity,
                         m.gravida               as gravida,
                         m.lmp,
                         m.edd_ultrasound        as edd,
                         m.hiv_status            as hiv_status_before_anc,
                         m.hiv_test_date         as test_date,
                         m.partner_hiv_status    as partner_status,
                         m.partner_hiv_test_date as partner_test_date,
                         m.blood_group           as blood_group,
                         p.status_in_prg         as status_in_mnch,
                         m.date_created          as date_created,
                         m.date_last_modified    as date_last_modified
                  from kenyaemr_etl.etl_mch_enrollment m
                         left join (select p.patient_id                                           as prg_patient,
                                           p.date_enrolled                                        as date_enrolled,
                                           if(p.date_completed is null, 'Active', (case d.discontinuation_reason
                                                                                     when 160035 then 'Completed'
                                                                                     when 159492 then 'Transferred Out'
                                                                                     when 160034 then 'Died'
                                                                                     when 5240 then 'Lost to Follow up'
                                                                                     else '' end))as status_in_prg
                                    from kenyaemr_etl.etl_patient_program p
                                           left join kenyaemr_etl.etl_patient_program_discontinuation d
                                             on p.patient_id = d.patient_id and p.date_completed = date(d.visit_date)
                                    where p.program = 'MCH-Mother Services')p
                           on m.patient_id = p.prg_patient and m.visit_date = p.date_enrolled
                  group by m.visit_date)m on d.patient_id = m.patient_id
       left join (select c.patient_id, c.visit_date as hei_enrolment_date, p.status_in_prg as status_in_cwc
                  from kenyaemr_etl.etl_hei_enrollment c
                         left join (select p.patient_id       as prg_patient,
                                           p.date_enrolled    as date_enrolled,
                                           d.discontinuation_reason,
                                           if(p.date_completed is null or p.date_completed = '', 'Active',
                                              (case d.discontinuation_reason
                                                 when 1267 then 'Completed'
                                                 when 159492 then 'Transferred Out'
                                                 when 160034 then 'Died'
                                                 when 5240 then 'Lost to Follow up'
                                                 else '' end))as status_in_prg
                                    from kenyaemr_etl.etl_patient_program p
                                           left join kenyaemr_etl.etl_patient_program_discontinuation d
                                             on p.patient_id = d.patient_id and p.date_completed = date(d.visit_date)
                                    where p.program = 'MCH-Child Services')p
                           on c.patient_id = p.prg_patient and c.visit_date = p.date_enrolled
                  group by c.visit_date)c on d.patient_id = c.patient_id
       join kenyaemr_etl.etl_default_facility_info i
where m.patient_id is not null
   or c.patient_id is not null;