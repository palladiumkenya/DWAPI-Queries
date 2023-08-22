select r.child            as BabyPatientPK,
       r.mother           as MotherPatientPK,
       r.uuid             as uuid,
       i.siteCode         as SiteCode,
       r.hei_id           as PatientHEI_ID,
       r.child_openmrs_id as PatientMNCH_ID,
       r.mother_ccc       as PatientIDCCC,
       'KenyaEMR'         as Emr,
       'Kenya HMIS II'    as Project,
       i.FacilityName     as FacilityName,
       r.date_created     as Date_Created,
       r.date_changed     as Date_Last_Modified,
       r.voided           as voided
from dwapi_etl.etl_patient_demographics d
         inner join (select r.person_a as mother,
                            r.uuid,
                            m.mother_ccc,
                            r.person_b as child,
                            c.child_openmrs_id,
                            c.hei_id,
                            c.hei_enr_date,
                            c.disc_hei,
                            c.hei_disc_date,
                            r.end_date as rel_end_date,
                            r.date_created,
                            r.date_changed,
                            r.voided,
                            m.latest_hiv_enrollment,
                            m.disc_patient,
                            m.hiv_disc_date
                     from openmrs.relationship r
                              inner join (select d.patient_id,
                                                 d.unique_patient_no                                   as mother_ccc,
                                                 d.openmrs_id                                          as mother_openmrs_id,
                                                 e.patient_id                                          as hiv_client,
                                                 e.latest_hiv_enrollment,
                                                 disc.patient_id                                       as disc_patient,
                                                 coalesce(disc.effective_disc, disc.latest_disc_visit) as hiv_disc_date
                                          from dwapi_etl.etl_patient_demographics d
                                                   inner join (select e.patient_id, max(e.visit_date) as latest_hiv_enrollment
                                                               from dwapi_etl.etl_hiv_enrollment e
                                                               group by e.patient_id) e on d.patient_id = e.patient_id
                                                   left join (select disc.patient_id,
                                                                     max(date(disc.visit_date)) as latest_disc_visit,
                                                                     mid(max(concat(date(disc.visit_date),
                                                                                    date(disc.effective_discontinuation_date))),
                                                                         11)                    as effective_disc
                                                              from dwapi_etl.etl_patient_program_discontinuation disc
                                                              where disc.program_name = 'HIV'
                                                              group by disc.patient_id) disc
                                                             on e.patient_id = disc.patient_id
                                          where d.gender = 'F') m
                                         on m.patient_id = r.person_a
                              inner join (select c.patient_id,
                                                 c.dob,
                                                 c.openmrs_id            as child_openmrs_id,
                                                 c.hei_no                as hei_id,
                                                 max(date(h.visit_date)) as hei_enr_date,
                                                 disc.patient_id         as disc_hei,
                                                 disc.latest_disc_visit  as hei_disc_date
                                          from dwapi_etl.etl_patient_demographics c
                                                   inner join dwapi_etl.etl_hei_enrollment h on c.patient_id = h.patient_id
                                                   left join (select disc.patient_id,
                                                                     max(date(disc.visit_date)) as latest_disc_visit
                                                              from dwapi_etl.etl_patient_program_discontinuation disc
                                                              where disc.program_name in ('MCH Child', 'MCH Child HEI')
                                                              group by disc.patient_id) disc
                                                             on h.patient_id = disc.patient_id
                                          group by c.patient_id) c
                                         on c.patient_id = r.person_b
                              inner join openmrs.relationship_type t
                                         on r.relationship = t.relationship_type_id and
                                            t.uuid = '8d91a210-c2cc-11de-8d13-0010c6dffd0f'
                     where (disc_hei is null or date(hei_enr_date) > date(hei_disc_date))
                       and (disc_patient is null or date(latest_hiv_enrollment) > date(hiv_disc_date))
                       and (r.end_date is null or date(r.end_date) > date(current_date))/* and r.voided = 0*/) r
                    on r.child = d.patient_id
         join kenyaemr_etl.etl_default_facility_info i;