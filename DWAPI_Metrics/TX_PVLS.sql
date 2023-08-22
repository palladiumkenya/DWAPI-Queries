select 'TX_PVLS'                                                                   AS 'INDICATOR',
       count(distinct a.patient_id)                                                as 'INDICATOR_VALUE',
       date_format(last_day(date_sub(current_date(), interval 1 MONTH)), '%Y%b%d') as 'INDICATOR_DATE'
               from(select t.patient_id,vl.vl_date,vl.vl_result,vl.urgency from (
               select fup.visit_date,fup.patient_id, max(e.visit_date) as enroll_date,
                      greatest(max(e.visit_date), ifnull(max(date(e.transfer_in_date)),'0000-00-00')) as latest_enrolment_date,
                      greatest(max(fup.visit_date), ifnull(max(d.visit_date),'0000-00-00')) as latest_vis_date,
                      greatest(mid(max(concat(fup.visit_date,fup.next_appointment_date)),11), ifnull(max(d.visit_date),'0000-00-00')) as latest_tca,
                      d.patient_id as disc_patient,
                      d.effective_disc_date as effective_disc_date,
                      max(d.visit_date) as date_discontinued,
                      de.patient_id as started_on_drugs,
                      de.date_started
               from dwapi_etl.etl_patient_hiv_followup fup
                      join dwapi_etl.etl_patient_demographics p on p.patient_id=fup.patient_id
                      join dwapi_etl.etl_hiv_enrollment e on fup.patient_id=e.patient_id
                      left outer join dwapi_etl.etl_drug_event de on e.patient_id = de.patient_id and de.program='HIV' and date(date_started) <= date(last_day(date_sub(current_date(), interval 1 MONTH)))
                      left outer JOIN
                        (select patient_id, coalesce(date(effective_discontinuation_date),visit_date) visit_date,max(date(effective_discontinuation_date)) as effective_disc_date from dwapi_etl.etl_patient_program_discontinuation
                         where date(visit_date) <= date(last_day(date_sub(current_date(), interval 1 MONTH))) and program_name='HIV'
                         group by patient_id
                        ) d on d.patient_id = fup.patient_id
               where fup.visit_date <= date(last_day(date_sub(current_date(), interval 1 MONTH)))
               group by patient_id
               having (started_on_drugs is not null and started_on_drugs <> '') and (
                   (
                       ((timestampdiff(DAY,date(latest_tca),date(last_day(date_sub(current_date(), interval 1 MONTH)))) <= 30 or timestampdiff(DAY,date(latest_tca),date(curdate())) <= 30) and ((date(d.effective_disc_date) > date(last_day(date_sub(current_date(), interval 1 MONTH))) or date(enroll_date) > date(d.effective_disc_date)) or d.effective_disc_date is null))
                         and (date(latest_vis_date) >= date(date_discontinued) or date(latest_tca) >= date(date_discontinued) or disc_patient is null)
                       )
                   ) order by date_started desc
               ) t
                 inner join (
                            select
                                   b.patient_id,
                                   max(b.visit_date) as vl_date,
                                   date_sub(date(last_day(date_sub(current_date(), interval 1 MONTH))) , interval 12 MONTH),
                                   mid(max(concat(b.visit_date,b.lab_test)),11) as lab_test,
                                   if(mid(max(concat(b.visit_date,b.lab_test)),11) = 856, mid(max(concat(b.visit_date,b.test_result)),11), if(mid(max(concat(b.visit_date,b.lab_test)),11)=1305 and mid(max(concat(visit_date,test_result)),11) = 1302, "LDL","")) as vl_result,
                                   mid(max(concat(b.visit_date,b.urgency)),11) as urgency
                            from (select x.patient_id as patient_id,x.visit_date as visit_date,x.lab_test as lab_test, x.test_result as test_result,urgency as urgency
                                  from dwapi_etl.etl_laboratory_extract x where x.lab_test in (1305,856)
                                  group by x.patient_id,x.visit_date order by visit_date desc)b
                            group by patient_id
                            having max(visit_date) between
                                       date_sub(date(last_day(date_sub(current_date(), interval 1 MONTH))), interval 12
                                                MONTH) and date(last_day(date_sub(current_date(), interval 1 MONTH)))
                            )vl
                   on t.patient_id = vl.patient_id  where (vl_result < 1000 or vl_result='LDL'))a;