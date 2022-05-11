# DWAPI one time dump query

SELECT
  dm.patient_id AS PatientPK,
  dm.unique_patient_no AS CCCNumber,
  dm.national_id_no AS NationalId,
  dm.passport_no AS Passport,
  dm.huduma_no AS HudumaNumber,
  dm.birth_certificate_no AS BirthCertificateNumber,
  dm.alien_no AS AlienIdNo,
  dm.driving_license_no AS DrivingLicenseNumber,
  dm.patient_clinic_number AS PatientClinicNumber,
  dm.given_name AS FirstName,
  dm.middle_name AS MiddleName,
  dm.family_name AS LastName,
  dm.DOB AS DateOfBirth,
  dm.Gender AS Sex,
  dm.marital_status AS MaritalStatus,
  dm.occupation AS Occupation,
  dm.education_level AS HighestLevelOfEducation,
  dm.phone_number AS PhoneNumber,
  '' AS AlternativePhoneNumber,
  '' AS SpousePhoneNumber,
  dm.next_of_kin AS NameOfNextOfKin,
  dm.next_of_kin_relationship AS NextOfKinRelationship,
  dm.next_of_kin_phone AS NextOfKinTelNo,
  pa.county AS County,
  pa.sub_county AS SubCounty,
  pa.ward AS Ward,
  pa.location AS Location,
  pa.village AS Village,
  pa.land_mark AS Landmark,
  (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
  (select siteCode from kenyaemr_etl.etl_default_facility_info) as MFLCode,
  (select siteCode from kenyaemr_etl.etl_default_facility_info) as SiteCode,
  0 as FacilityID,
  'KHMIS' as Project,
  'KenyaEMR' as Emr,
  reg.art_start_date as DateOfInitiation,
  reg.last_regimen as LastRegimen,
  reg.last_regimen_line as LastRegimenLine,
  disc.ExitReason AS TreatmentOutcome,
  reg.latest_vis_date  AS DateOfLastEncounter,
  lab.lastViralLoadDate AS DateOfLastViralLoad,
  reg.latest_tca  AS NextAppointmentDate,
  if(cc.patient_id IS NOT NULL,'YES','NO') as  Current_On_ART
from kenyaemr_etl.etl_hiv_enrollment hiv
  join kenyaemr_etl.etl_patient_demographics dm on dm.patient_id = hiv.patient_id
  left join kenyaemr_etl.etl_person_address pa on pa.patient_id = hiv.patient_id
  left join (select d.patient_id,
               coalesce(max(date(d.effective_discontinuation_date)),
                        max(date(d.visit_date)))as ExitDate,
               (case d.discontinuation_reason
                when 159492 then 'Transfer Out'
                when 160034 then 'Died'
                when 5240 then 'LTFU'
                when 819 then 'Stopped Treatment'
                else'' end)                     as ExitReason,
               max(d.date_last_modified)        as date_last_modified
             from kenyaemr_etl.etl_patient_program_discontinuation d
             where d.program_name = 'HIV'
             group by d.patient_id) disc on disc.patient_id = dm.patient_id
  left join (select lb.patient_id,
               lb.date_test_requested as lastViralLoadDate
             from kenyaemr_etl.etl_laboratory_extract lb
             where lb.lab_test in (1305,856)
             group by lb.patient_id) lab on lab.patient_id = dm.patient_id
  left join (select e.patient_id,
               if(enr.date_started_art_at_transferring_facility is not null,enr.date_started_art_at_transferring_facility,
                  e.date_started)as art_start_date, e.date_started, e.gender,e.dob,d.visit_date as dis_date, if(d.visit_date is not null, 1, 0) as TOut,
               e.regimen, e.regimen_line, e.alternative_regimen, max(fup.next_appointment_date) as latest_tca,
               last_art_date,last_regimen,last_regimen_line,
               if(enr.transfer_in_date is not null, 1, 0) as TIn, max(fup.visit_date) as  latest_vis_date,
               e.date_created,e.date_last_modified
             from (select e.patient_id,p.dob,p.Gender,min(e.date_started) as date_started,
                                                      max(e.date_started) as last_art_date,
                                                      mid(min(concat(e.date_started,e.regimen_name)),11) as regimen,
                                                      mid(min(concat(e.date_started,e.regimen_line)),11) as regimen_line,
                                                      mid(max(concat(e.date_started,e.regimen_name)),11) as last_regimen,
                                                      mid(max(concat(e.date_started,e.regimen_line)),11) as last_regimen_line,
                                                      max(if(discontinued,1,0))as alternative_regimen,
                                                      GREATEST(COALESCE(p.date_created, ph.date_created), COALESCE(ph.date_created, p.date_created)) as date_created,
                                                      GREATEST(COALESCE(p.date_last_modified, ph.date_last_modified), COALESCE(ph.date_last_modified, p.date_last_modified)) as date_last_modified
                   from kenyaemr_etl.etl_drug_event e
                     join kenyaemr_etl.etl_patient_demographics p on p.patient_id=e.patient_id
                     left join  kenyaemr_etl.etl_pharmacy_extract ph on ph.patient_id = e.patient_id and is_arv=1
                   group by e.patient_id) e
               left outer join kenyaemr_etl.etl_patient_program_discontinuation d on d.patient_id=e.patient_id
               left outer join kenyaemr_etl.etl_hiv_enrollment enr on enr.patient_id=e.patient_id
               left outer join kenyaemr_etl.etl_patient_hiv_followup fup on fup.patient_id=e.patient_id
             group by e.patient_id)reg on reg.patient_id=hiv.patient_id
  left join (select ca.patient_id
             from kenyaemr_etl.etl_current_in_care ca where ca.started_on_drugs is not null
            ) cc on cc.patient_id = dm.patient_id


