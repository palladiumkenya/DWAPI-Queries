select 'RETENTION_ON_ART_VL_1000_12_MONTHS'                                        as 'INDICATOR',
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
               inner join(select patient_id,
                                 max(visit_date)                                                                      as vl_date,
                                 if(mid(max(concat(visit_date, lab_test)), 11) = 856,
                                    mid(max(concat(visit_date, test_result)), 11), if(
                                                    mid(max(concat(visit_date, lab_test)), 11) = 1305 and
                                                    mid(max(concat(visit_date, test_result)), 11) = 1302, "LDL",
                                                    ""))                                                              as vl_result,
                                 mid(max(concat(visit_date, urgency)), 11)                                            as urgency,
                                 DATE_ADD(DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                                                   day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1
                                                   DAY), INTERVAL -12 MONTH),
                                 date(date(last_day(date_sub(current_date(), interval 1 MONTH))))
                          from dwapi_etl.etl_laboratory_extract
                          where lab_test in (1305, 856)
                            and visit_date between DATE_ADD(
                                  DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                                           day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1 DAY),
                                  INTERVAL -12 MONTH)
                              and date(date(last_day(date_sub(current_date(), interval 1 MONTH))))
                          group by patient_id
                          having mid(max(concat(visit_date, test_result)), 11) is not null
                              or mid(max(concat(visit_date, test_result)), 11) <> '') vl on e.patient_id = vl.patient_id
      where date(e.date_started) between DATE_ADD(
              DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                       day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1 DAY), INTERVAL -12 MONTH) and
          date(last_day(DATE_ADD(DATE_SUB(date(last_day(date_sub(current_date(), interval 1 MONTH))), INTERVAL
                                          day(date(last_day(date_sub(current_date(), interval 1 MONTH)))) - 1 DAY),
                                 INTERVAL -12 MONTH)))
        and (vl.vl_result < 1000 or vl.vl_result = 'LDL')
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