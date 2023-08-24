select 'RETENTION_ON_ART_12_MONTHS'                                                as 'INDICATOR',
       count(net.patient_id)                                                       AS INDICATOR_VALUE,
       date_format(last_day(date_sub(current_date(), interval 1 MONTH)), '%Y%b%d') as 'INDICATOR_DATE'
from (select e.patient_id,
             e.date_started,
             d.visit_date                                                                      as dis_date,
             if(d.visit_date is not null and d.discontinuation_reason = 159492, 1, 0)          as TOut,
             d.date_died,
             mid(max(concat(fup.visit_date, fup.next_appointment_date)), 11)                   as latest_tca,
             if(enr.transfer_in_date is not null, 1, 0)                                        as TIn,
             max(fup.visit_date)                                                               as latest_vis_date,
             DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                      day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1
                      DAY)                                                                     as first_day_of_prev_month,
             date(last_day(date_sub(current_date(), interval 1 MONTH)))                        as last_day_of_prev_month,
             DATE_ADD(DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                               day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1 DAY), INTERVAL -12
                      MONTH)                                                                   as cohort_start_date,
             date(last_day(DATE_ADD(DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                                             day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1 DAY),
                                    INTERVAL -12 MONTH)))                                      as cohort_end_date
      from (select e.patient_id, p.dob, p.Gender, min(e.date_started) as date_started
            from dwapi_etl.etl_drug_event e
                     join dwapi_etl.etl_patient_demographics p on p.patient_id = e.patient_id
            where e.program = 'HIV'
            group by e.patient_id) e
               left outer join dwapi_etl.etl_patient_program_discontinuation d on d.patient_id = e.patient_id and
                                                                                  d.program_uuid =
                                                                                  '2bdada65-4c72-4a48-8730-859890e25cee'
               left outer join dwapi_etl.etl_hiv_enrollment enr on enr.patient_id = e.patient_id
               left outer join dwapi_etl.etl_patient_hiv_followup fup on fup.patient_id = e.patient_id
      where date(e.date_started) between DATE_ADD(
              DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                       day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1 DAY), INTERVAL -12 MONTH) and
                date(last_day(DATE_ADD(DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                                                day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1
                                                DAY), INTERVAL -12 MONTH)))
      group by e.patient_id
      having (dis_date > date(last_day(date_sub(current_date(), interval 1 MONTH))) or dis_date is null or TOut = 0)
         and (
              (date(latest_tca) > date(last_day(date_sub(current_date(), interval 1 MONTH))) and
               (date(latest_tca) > date(dis_date) or dis_date is null)) or
              (((date(latest_tca) between DATE_ADD(
                      DATE_SUB(current_date(), INTERVAL DAYOFMONTH(current_date()) - 1 DAY), INTERVAL -1
                      MONTH) and date(last_day(date_sub(current_date(), interval 1 MONTH)))) and
                (date(latest_tca) >= date(latest_vis_date)))) or
              (((date(latest_tca) between DATE_ADD(
                      DATE_SUB(current_date(), INTERVAL DAYOFMONTH(current_date()) - 1 DAY), INTERVAL -1
                      MONTH) and date(last_day(date_sub(current_date(), interval 1 MONTH)))) and
                (date(latest_vis_date) >= date(latest_tca)) or date(latest_tca) > curdate())) and
              (date(latest_tca) > date(dis_date) or dis_date is null)
          )) net;