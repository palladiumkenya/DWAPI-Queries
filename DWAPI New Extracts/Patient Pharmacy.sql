select distinct
                '' AS Provider,'' AS SatelliteName, 0 AS FacilityId, d.unique_patient_no as PatientID,
                d.patient_id as PatientPK,
                (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
                (select siteCode from kenyaemr_etl.etl_default_facility_info) as siteCode,
                ph.visit_id as VisitID,
-- if(cn2.name is not null, cn2.name,cn.name) as Drug,
                case
                  when is_arv=1 then ph.drugreg
                  else if(cn2.name is not null, cn2.name,cn.name) END as Drug,
                ph.visit_date as DispenseDate,
                ph.duration AS duration,
                ph.duration AS PeriodTaken,
                fup.next_appointment_date as ExpectedReturn,
                fup.next_appointment_date as ExpectedReturn,
                'KenyaEMR' as Emr,
                'Kenya HMIS II' as Project,
                CASE WHEN is_arv=1 THEN 'ARV'
                     WHEN is_ctx=1 OR is_dapsone= 1 THEN 'Prophylaxis' END AS TreatmentType,
                ph.RegimenLine,
                CASE WHEN is_ctx=1 THEN 'CTX'
                     WHEN is_dapsone =1 THEN 'DAPSON' END AS ProphylaxisType,
                CAST(now() as Date) AS DateExtracted,
                ph.date_created,
                GREATEST(COALESCE(ph.date_last_modified, d.date_last_modified), COALESCE(d.date_last_modified, ph.date_last_modified)) as date_last_modified
from (SELECT * FROM (
                    select patient_id, visit_id,visit_date,encounter_id,drug,is_arv, is_ctx,is_dapsone,drug_name as drugreg,frequency,
                           '' as DispenseDate,duration, duration PeriodTaken,
                           ''ExpectedReturn, CASE WHEN is_ctx=1 OR is_dapsone= 1 THEN 'Prophylaxis' END AS TreatmentType,'' as RegimenLine,
                           CASE WHEN is_ctx=1 THEN 'CTX'
                                WHEN is_dapsone =1 THEN 'DAPSON' END AS ProphylaxisType,
                           ph.date_created, ph.date_last_modified from kenyaemr_etl.etl_pharmacy_extract ph
                                                                         left outer join concept_name cn2 on cn2.concept_id=ph.drug and cn2.concept_name_type='SHORT'
                                                                                                               and cn2.locale='en' where is_ctx=1 OR is_dapsone= 1
                    GROUP BY patient_id, visit_id,visit_date,encounter_id
                    UNION

                    SELECT patient_id,''visit_id,visit_date,encounter_id,regimen drug,1 as is_arv, 0 as is_ctx, 0 as is_dapsone, regimen_name as drugreg, '' frequency, date_started as DispenseDate,''duration,''PeriodTaken,
                           ''ExpectedReturn, 'ARV' AS TreatmentType,regimen_line as RegimenLine,NULL as ProphylaxisType,
                           null as date_created,null as date_last_modified FROM kenyaemr_etl.etl_drug_event where program='HIV'
                    GROUP BY patient_id, visit_id,visit_date,encounter_id
                    )A )ph
       join kenyaemr_etl.etl_patient_demographics d on d.patient_id=ph.patient_id
       left outer join concept_name cn on cn.concept_id=ph.drug and cn.concept_name_type='FULLY_SPECIFIED'
                                            and cn.locale='en'
       left outer join concept_name cn2 on cn2.concept_id=ph.drug and cn2.concept_name_type='SHORT'
                                             and cn.locale='en'
       left outer join kenyaemr_etl.etl_patient_hiv_followup fup on fup.encounter_id=ph.encounter_id
                                                                      and fup.patient_id=ph.patient_id
where unique_patient_no is not null and (is_arv=1 OR is_ctx=1 OR is_dapsone =1 ) and drugreg is not null
order by ph.patient_id,ph.visit_date;