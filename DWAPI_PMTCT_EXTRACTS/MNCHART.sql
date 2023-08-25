select d.patient_id                                                                          as PatientPK,
       de.uuid                                                                               as uuid,
       i.siteCode                                                                            as SiteCode,
       d.openmrs_id                                                                          as PatientMNCHCWC_ID,
       d.hei_no                                                                              as PatientHEI_ID,
       d.unique_patient_no                                                                   as PatientID,
       'KenyaEMR'                                                                            as Emr,
       'Kenya HMIS II'                                                                       as Project,
       i.FacilityName                                                                        as FacilityName,
       e.date_first_enrolled_in_care                                                         as RegistrationAtCCC,
       least(ifnull(mid(min(concat(e.visit_date, e.date_started_art_at_transferring_facility)), 11),
                    de.date_started_art + interval rand() * 1000 year), de.date_started_art) as StartARTDate,
       m.ti_care_facility                                                                    as FacilityReceivingARTCare,
       de.start_regimen                                                                      as StartRegimen,
       de.start_regimen_line                                                                 as StartRegimenLine,
       if(p.patient_id is null, 'ACTIVE', p.status_at_ccc)                                   as StatusAtCCC,
       de.last_art_date                                                                      as DateStartedCurrentRegimen,
       de.last_regimen                                                                       as LastRegimen,
       de.last_regimen_line                                                                  as LastRegimenLine,
       de.Date_Created                                                                       as Date_Created,
       de.Date_Last_Modified                                                                 as Date_Last_Modified,
       de.voided                                                                             as voided
from dwapi_etl.etl_patient_demographics d
         left join (select m.patient_id,
                           m.uuid,
                           min(m.visit_date) as first_mch_enrolment_date,
                           m.ti_care_facility,
                           m.ti_curent_regimen,
                           m.ti_date_started_art,
                           m.date_last_modified,
                           m.voided
                    from dwapi_etl.etl_mch_enrollment m
                    group by m.patient_id) m on d.patient_id = m.patient_id
         left join (select c.patient_id, min(c.visit_date) as first_hei_enrolment_date, c.date_last_modified
                    from dwapi_etl.etl_hei_enrollment c
                    group by c.patient_id) c on d.patient_id = c.patient_id
         left join (select e.patient_id,
                           e.uuid,
                           e.visit_date,
                           e.date_started_art_at_transferring_facility,
                           least(min(e.visit_date), mid(min(concat(e.visit_date,
                                                                   coalesce(e.date_first_enrolled_in_care, date('9999-12-31')))),
                                                        11)) as date_first_enrolled_in_care,
                           e.date_last_modified,
                           e.voided
                    from dwapi_etl.etl_hiv_enrollment e
                    group by e.patient_id) e on d.patient_id = e.patient_id
         left join (select de.patient_id,
                           de.uuid as uuid,
                           min(de.date_started)                                   as date_started_art,
                           mid(min(concat(de.date_started, de.regimen_name)), 11) as start_regimen,
                           mid(min(concat(de.date_started, de.regimen_line)), 11) as start_regimen_line,
                           mid(max(concat(de.date_started, de.regimen_name)), 11) as last_regimen,
                           max(de.date_started)                                   as last_art_date,
                           mid(max(concat(de.date_started, de.regimen_line)), 11) as last_regimen_line,
                           de.date_created                                        as Date_Created,
                           de.date_last_modified                                  as Date_Last_Modified,
                           de.voided as voided
                    from dwapi_etl.etl_drug_event de where de.program = 'HIV'
                    group by de.patient_id) de on d.patient_id = de.patient_id
         left join (select p.patient_id,
                           max(date(p.visit_date))                                                    as latest_disc,
                           mid(max(concat(date(p.visit_date), (case p.discontinuation_reason
                                                                   when 159492 then 'TransferOut'
                                                                   when 5240 then 'LTFU'
                                                                   when 160034 then 'Dead'
                                                                   when 5622 then 'OTHER' end))), 11) as status_at_ccc,
                           date_last_modified
                    from dwapi_etl.etl_patient_program_discontinuation p
                    group by p.patient_id
                    having mid(max(concat(date(p.visit_date), p.program_name)), 11) = 'HIV') p
                   on d.patient_id = p.patient_id
         join kenyaemr_etl.etl_default_facility_info i
where (m.patient_id is not null
    and e.patient_id is not null)
   or (m.patient_id is not null and
       (m.ti_date_started_art is not null or m.ti_care_facility is not null or m.ti_curent_regimen is not null))
   or (c.patient_id is not null and e.patient_id is not null)
group by d.patient_id;