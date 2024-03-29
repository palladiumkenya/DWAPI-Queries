# Metric for DWAPI one time dump
select 'DWAPI_ONE_TIME_DUMP'                 as INDICATOR,
       count(a.PatientPK)                    AS INDICATOR_VALUE,
       date_format(current_date(), '%Y%b%d') as INDICATOR_DATE
from (SELECT hiv.patient_id AS PatientPK
      from dwapi_etl.etl_hiv_enrollment hiv
               join dwapi_etl.etl_patient_demographics dm on dm.patient_id = hiv.patient_id
               left join dwapi_etl.etl_person_address pa on pa.patient_id = hiv.patient_id
               left join (select d.patient_id
                          from dwapi_etl.etl_patient_program_discontinuation d
                          where d.program_name = 'HIV'
                          group by d.patient_id) disc on disc.patient_id = dm.patient_id
               left join (select lb.patient_id
                          from dwapi_etl.etl_laboratory_extract lb
                          where lb.lab_test in (1305, 856)
                          group by lb.patient_id) lab on lab.patient_id = dm.patient_id
               left join (select e.patient_id
                          from (select e.patient_id
                                from dwapi_etl.etl_drug_event e
                                group by e.patient_id) e
                                   left outer join dwapi_etl.etl_patient_hiv_followup fup
                                                   on fup.patient_id = e.patient_id
                          group by e.patient_id) reg on reg.patient_id = hiv.patient_id
               left join (select ca.patient_id
                          from kenyaemr_etl.etl_current_in_care ca
                          where ca.started_on_drugs is not null
      ) cc on cc.patient_id = dm.patient_id
      group by hiv.patient_id) a;