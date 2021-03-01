select
       '' AS SatelliteName,
       0 AS FacilityId,
       d.unique_patient_no as PatientID,
       d.patient_id as PatientPK,
      (select siteCode from kenyaemr_etl.etl_default_facility_info) as siteCode,
      (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
       '' as ExitDescription,
       'KenyaEMR' as Emr,
       'Kenya HMIS II' as Project,
       CAST(now() as Date) AS DateExtracted,
       max(disc.visit_date) AS ExitDate,
       mid(max(concat(visit_date,(case discontinuation_reason
                                    when 159492 then "Transfer Out"
                                    when 160034 then "Died"
                                    when 5240 then "LTFU"
                                    when 819 then "Cannot afford Treatment"
                                    when 5622 then "Other"
                                    when 1067 then "Unknown"
                                    else "" end), "" )),20) as ExitReason,
       (case mid(max(concat(date(disc.visit_date),disc.trf_out_verified)),11) when 1065 then 'Yes' when 1066 then 'No' end) as TOVerified,
       mid(max(concat(date(disc.visit_date),disc.trf_out_verification_date)),11) as TOVerifiedDate,
       disc.date_created,
       disc.date_last_modified as date_last_modified
from kenyaemr_etl.etl_patient_program_discontinuation disc
       join kenyaemr_etl.etl_patient_demographics d on d.patient_id=disc.patient_id
where d.unique_patient_no is not null and disc.program_name='HIV'
group by PatientID
order by disc.visit_date ASC;
