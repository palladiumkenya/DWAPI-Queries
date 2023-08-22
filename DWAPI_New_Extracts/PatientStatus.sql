select ''                                                                          AS SatelliteName,
       0                                                                           AS FacilityId,
       d.unique_patient_no                                                         as PatientID,
       disc.uuid                                                                   as uuid,
       d.patient_id                                                                as PatientPK,
       i.siteCode                                                                  as SiteCode,
       i.FacilityName                                                              as FacilityName,
       ''                                                                          as ExitDescription,
       'KenyaEMR'                                                                  as Emr,
       'Kenya HMIS II'                                                             as Project,
       max(date(disc.visit_date))                                                  AS ExitDate,
       max(date(disc.effective_discontinuation_date))                              AS EffectiveDiscontinuationDate,
       mid(max(concat(visit_date, (case discontinuation_reason
                                       when 159492 then 'Transfer Out'
                                       when 160034 then 'Died'
                                       when 5240 then 'LTFU'
                                       when 819 then 'Stopped Treatment'
                                       else '' end), '')), 20)                     as ExitReason,
       if(e.latest_enrolment_date > greatest(coalesce(max(date(disc.effective_discontinuation_date)), '0000-00-00'),
                                             coalesce(max(date(disc.visit_date)), '0000-00-00')),
          e.latest_enrolment_date,
          null)                                                                    as ReEnrollmentDate,
       (case mid(max(concat(date(disc.visit_date), disc.death_reason)), 11)
            when 163324 then 'HIV disease resulting in TB'
            when 116030 then 'HIV disease resulting in cancer'
            when 160159 then 'HIV disease resulting in other infectious and parasitic diseases'
            when 160158 then 'Other HIV disease resulting in other diseases or conditions leading to death'
            when 133478 then 'Other natural causes not directly related to HIV'
            when 145439 then 'Non-communicable diseases such as Diabetes and hypertension'
            when 123812 then 'Non-natural causes'
            when 42917 then 'Unknown cause'
            else '' end)                                                           as ReasonForDeath,
       (case mid(max(concat(date(disc.visit_date), disc.specific_death_cause)), 11)
            when 156673 then 'HIV disease resulting in mycobacterial infection'
            when 155010 then 'HIV disease resulting in Kaposis sarcoma'
            when 156667 then 'HIV disease resulting in Burkitts lymphoma'
            when 115195 then 'HIV disease resulting in other types of non-Hodgkin lymphoma'
            when 157593
                then 'HIV disease resulting in other malignant neoplasms of lymphoid and haematopoietic and related tissue'
            when 156672 then 'HIV disease resulting in multiple malignant neoplasms'
            when 159988 then 'HIV disease resulting in other malignant neoplasms'
            when 5333 then 'HIV disease resulting in other bacterial infections'
            when 116031 then 'HIV disease resulting in unspecified malignant neoplasms'
            when 123122 then 'HIV disease resulting in other viral infections'
            when 156669 then 'HIV disease resulting in cytomegaloviral disease'
            when 156668 then 'HIV disease resulting in candidiasis'
            when 5350 then 'HIV disease resulting in other mycoses'
            when 882
                then 'HIV disease resulting in Pneumocystis jirovecii pneumonia - HIV disease resulting in Pneumocystis carinii pneumonia'
            when 156671 then 'HIV disease resulting in multiple infections'
            when 160159 then 'HIV disease resulting in other infectious and parasitic diseases'
            when 171
                then 'HIV disease resulting in unspecified infectious or parasitic disease - HIV disease resulting in infection NOS'
            when 156670
                then 'HIV disease resulting in other specified diseases including encephalopathy or lymphoid interstitial pneumonitis or wasting syndrome and others'
            when 160160
                then 'HIV disease resulting in other conditions including acute HIV infection syndrome or persistent generalized lymphadenopathy or hematological and immunological abnormalities and others'
            when 161548 then 'HIV disease resulting in Unspecified HIV disease'
           end)                                                                    as SpecificDeathReason,
       (case mid(max(concat(date(disc.visit_date), disc.trf_out_verified)), 11)
            when 1065 then 'Yes'
            when 1066 then 'No' end)                                               as TOVerified,
       mid(max(concat(date(disc.visit_date), disc.trf_out_verification_date)), 11) as TOVerifiedDate,
       mid(max(concat(disc.visit_date, disc.date_died)), 11)                       as DeathDate,
       disc.date_created                                                           as Date_Created,
       disc.date_last_modified                                                     as Date_Last_Modified
from dwapi_etl.etl_patient_program_discontinuation disc
         left join (select e.patient_id                                       as patient_id,
                           max(e.visit_date)                                  as latest_enrolment_date,
                           mid(max(concat(e.visit_date, e.patient_type)), 11) as patient_type
                    from dwapi_etl.etl_hiv_enrollment e
                    group by e.patient_id) e on e.patient_id = disc.patient_id
         join dwapi_etl.etl_patient_demographics d on d.patient_id = disc.patient_id
         join kenyaemr_etl.etl_default_facility_info i
where d.unique_patient_no is not null
  and disc.program_name = 'HIV'
group by PatientID
order by disc.visit_date ASC;
