select p.baby_patient_id    as BabyPatientPK,
       p.mother_patient_id  as MotherPatientPK,
       i.siteCode           as SiteCode,
       p.hei_id             as PatientHEI_ID,
       p.openmrs_id         as PatientMNCH_ID,
       p.ccc_no             as PatientIDCCC,
       'KenyaEMR'           as Emr,
       'Kenya HMIS II'      as Project,
       i.FacilityName       as FacilityName,
       p.date_created       as Date_Created,
       p.date_last_modified as Date_Last_Modified
from kenyaemr_etl.etl_patient_demographics d
       inner join (select m.ccc_no,
                          c.hei_id,
                          m.patient_id      as mother_patient_id,
                          c.baby_patient_id as baby_patient_id,
                          m.openmrs_id      as openmrs_id,
                          c.date_created,
                          c.date_last_modified
                   from (select m.patient_id, d.openmrs_id as openmrs_id, d.unique_patient_no as ccc_no
                         from kenyaemr_etl.etl_mch_enrollment m
                                inner join kenyaemr_etl.etl_patient_demographics d on m.patient_id = d.patient_id
                         group by m.patient_id)m
                          inner join (select c.patient_id        as baby_patient_id,
                                             d.hei_no            as hei_id,
                                             c.parent_ccc_number as mother_ccc_no,
                                             c.date_created,
                                             c.date_last_modified
                                      from kenyaemr_etl.etl_hei_enrollment c
                                             inner join kenyaemr_etl.etl_patient_demographics d
                                               on c.patient_id = d.patient_id
                                      group by c.patient_id)c on m.ccc_no = c.mother_ccc_no)p
         on d.unique_patient_no = p.ccc_no
       join kenyaemr_etl.etl_default_facility_info i;