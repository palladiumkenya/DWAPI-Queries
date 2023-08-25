select 'HTS_TST_POS'                                                               AS 'INDICATOR',
       count(distinct t.patient_id)                                                as 'INDICATOR_VALUE',
       date_format(last_day(date_sub(current_date(), interval 1 MONTH)), '%Y%b%d') as 'INDICATOR_DATE'
from dwapi_etl.etl_hts_test t
         inner join dwapi_etl.etl_patient_demographics d on d.patient_id = t.patient_id
where t.voided = 0
  and date(t.visit_date) between DATE_ADD(DATE_SUB(current_date(), INTERVAL DAYOFMONTH(current_date()) - 1 DAY),
                                          INTERVAL -1
                                          MONTH) and date(last_day(date_sub(current_date(), interval 1 MONTH)))
  and t.test_type = 1
  and t.patient_given_result = 'Yes'
  and t.final_test_result = 'Positive';
