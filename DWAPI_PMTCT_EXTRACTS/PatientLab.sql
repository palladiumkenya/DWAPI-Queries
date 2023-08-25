select d.patient_id         as PatientPK,
       l.uuid               as uuid,
       i.siteCode           as SiteCode,
       d.openmrs_id         as PatientMNCH_ID,
       ''                   as FacilityID,
       'KenyaEMR'           as Emr,
       'Kenya HMIS II'      as Project,
       i.FacilityName       as FacilityName,
       ''                   as SatelliteName,
       l.visit_id           as VisitID,
       l.sample_date        as OrderedByDate,
       l.results_date       as ReportedByDate,
       l.lab_test           as TestName,
       l.test_result        as TestResult,
       l.order_reason       as LabReason,
       l.date_created       as Date_Created,
       l.date_last_modified as Date_Last_Modified,
       l.voided             as voided
from dwapi_etl.etl_patient_demographics d
         inner join (select e.patient_id from dwapi_etl.etl_hiv_enrollment e) e on d.patient_id = e.patient_id
         inner join (select m.patient_id from dwapi_etl.etl_mch_enrollment m) m on d.patient_id = m.patient_id
         inner join (select l.patient_id,
                            l.uuid,
                            l.visit_id,
                            l.date_test_requested             as sample_date,
                            l.date_test_result_received       as results_date,
                            case l.lab_test
                                when 5497 then 'CD4 Count'
                                when 730 then 'CD4 PERCENT '
                                when 654 then 'ALT'
                                when 790 then 'Serum creatinine (umol/L)'
                                when 856 then 'HIV VIRAL LOAD'
                                when 1305 then 'HIV VIRAL LOAD'
                                when 21 then 'Hemoglobin (HGB)'
                                else '' end                   as lab_test,
                            case l.order_reason
                                when 843 then 'Regimen failure'
                                when 1259 then 'CHANGE REGIMEN'
                                when 1434 then 'PREGNANCY'
                                when 159882 then 'breastfeeding'
                                when 160566 then 'Immunologic failure'
                                when 160569 then 'Virologic failure'
                                when 161236 then 'Routine'
                                when 162080 then 'Baseline'
                                when 162081 then 'Repeat'
                                when 163523 then 'Clinical failure'
                                else '' end                   as order_reason,
                            if(l.lab_test = 299, (case l.test_result
                                                      when 1228 then 'REACTIVE'
                                                      when 1229 then 'NON-REACTIVE'
                                                      when 1304 then 'POOR SAMPLE QUALITY' end),
                               if(l.lab_test = 1030, (case l.test_result
                                                          when 1138 then 'INDETERMINATE'
                                                          when 664 then 'NEGATIVE'
                                                          when 703 then 'POSITIVE'
                                                          when 1304 then 'POOR SAMPLE QUALITY' end),
                                  if(l.lab_test = 302, (case l.test_result
                                                            when 1115 then 'Normal'
                                                            when 1116 then 'Abnormal'
                                                            when 1067 then 'Unknown' end),
                                     if(l.lab_test = 32, (case l.test_result
                                                              when 664 then 'NEGATIVE'
                                                              when 703 then 'POSITIVE'
                                                              when 1138 then 'INDETERMINATE' end),
                                        if(l.lab_test = 1305, (case l.test_result
                                                                   when 1306 then 'BEYOND DETECTABLE LIMIT'
                                                                   when 1301 then 'DETECTED'
                                                                   when 1302 then 'LDL'
                                                                   when 1304 then 'POOR SAMPLE QUALITY' end),
                                           l.test_result))))) as test_result,
                            l.date_created,
                            l.date_last_modified,
                            l.voided
                     from dwapi_etl.etl_laboratory_extract l) l on d.patient_id = l.patient_id
         join kenyaemr_etl.etl_default_facility_info i;