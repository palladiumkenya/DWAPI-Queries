select 'HTS_TESTED'                                                                as 'INDICATOR',
       count(distinct t.patient_id)                                                AS INDICATOR_VALUE,
       date_format(last_day(date_sub(current_date(), interval 1 MONTH)), '%Y%b%d') as 'INDICATOR_DATE'
from dwapi_etl.etl_hts_test t
         inner join dwapi_etl.etl_patient_demographics d on d.patient_id = t.patient_id
where test_type = 1
  and t.voided = 0
  and t.visit_date between DATE_ADD(DATE_SUB(current_date(), INTERVAL DAYOFMONTH(current_date()) - 1 DAY), INTERVAL -1
                                    MONTH)
    and date(last_day(date_sub(current_date(), interval 1 MONTH)));