select pkv.pkv                                                         as PKV,
       d.patient_id                                                    as PatientPK,
       i.siteCode                                                      as SiteCode,
       d.openmrs_id                                                    as PatientMNCH_ID,
       d.hei_no                                                        as PatientHEI_ID,
       'KenyaEMR'                                                      as Emr,
       'Kenya HMIS II'                                                 as Project,
       i.FacilityName                                                  as FacilityName,
       (case d.Gender when 'F' then 'Female' when 'M' then 'Male' end) as Gender,
       d.DOB                                                           as DOB,
       coalesce(c.hei_enrolment_date, m.mch_enrolment_date)            as VisitDate,
       coalesce(c.hei_encounter_id, m.mch_encounter_id)                as EncounterId,
       d.occupation                                                    as Occupation,
       d.marital_status                                                as MaritalStatus,
       d.education_level                                               as EducationLevel,
       a.county                                                        as PatientResidentCounty,
       a.sub_county                                                    as PatientResidentSubCounty,
       a.ward                                                          as PatientResidentWard,
       (case e.in_school when 1 then 'Yes' when 2 then 'No' end)       as Inschool,
       d.date_created                                                  as Date_Created,
       d.date_last_modified                                            as Date_Last_Modified
from kenyaemr_etl.etl_patient_demographics d
       left join (select m.patient_id, m.visit_date as mch_enrolment_date, m.encounter_id as mch_encounter_id
                  from kenyaemr_etl.etl_mch_enrollment m)m on d.patient_id = m.patient_id
       left join (select c.patient_id, c.visit_date as hei_enrolment_date, c.encounter_id as hei_encounter_id
                  from kenyaemr_etl.etl_hei_enrollment c)c on d.patient_id = c.patient_id
       left join (select a.patient_id, a.county, a.sub_county, a.ward from kenyaemr_etl.etl_person_address a)a
         on d.patient_id = a.patient_id
       left join (select e.patient_id as patient_id, e.in_school as in_school from kenyaemr_etl.etl_hiv_enrollment e)e
         on d.patient_id = e.patient_id
       inner join (select x.patient_id as patient_id,
                          x.sxFirstName,
                          x.sxLastname,
                          x.sxMiddleName,
                          x.dmFirstName,
                          x.dmLastName,
                          x.dmMiddleName,
                          x.Gender,
                          x.DOB,
                          CASE
                            WHEN locate(';', dmLastName) > 0 THEN CONCAT(
                                                                    CAST(LEFT(Gender, 1) AS CHAR CHARACTER SET utf8),
                                                                    CAST(sxFirstName AS CHAR CHARACTER SET utf8), CAST(
                                                                                                                    SUBSTRING(dmLastName, locate(';', dmLastName) + 1, LENGTH(dmLastName))
                                                                                                                    AS
                                                                                                                    CHAR CHARACTER SET utf8),
                                                                    CAST(LTRIM(RTRIM(DATE_FORMAT(DOB, '%Y'))) AS CHAR CHARACTER SET utf8)
                              )
                            ELSE CONCAT(
                                   CAST(LEFT(Gender, 1)AS CHAR CHARACTER SET utf8),
                                   CAST(sxFirstName AS CHAR CHARACTER SET utf8),
                                   CAST(dmLastName AS CHAR CHARACTER SET utf8),
                                   CAST(LTRIM(RTRIM(DATE_FORMAT(DOB, '%Y'))) AS CHAR CHARACTER SET utf8)
                              )
                              END      AS PKV
                   from (SELECT patient_id,
                                SOUNDEX(UPPER(REPLACE(given_name, '0', 'O')))                           AS sxFirstName,
                                SOUNDEX(UPPER(REPLACE(family_name, '0', 'O')))                          AS sxLastName,
                                SOUNDEX(UPPER(REPLACE(middle_name, '0', 'O')))                          AS sxMiddleName,
                                fn_getPatientNameDoubleMetaphone(UPPER(REPLACE(given_name, '0', 'O')))  AS dmFirstName,
                                fn_getPatientNameDoubleMetaphone(UPPER(REPLACE(family_name, '0', 'O'))) AS dmLastName,
                                fn_getPatientNameDoubleMetaphone(UPPER(REPLACE(middle_name, '0', 'O'))) AS dmMiddleName,
                                Gender,
                                DOB
                         FROM kenyaemr_etl.etl_patient_demographics)x)pkv on pkv.patient_id = d.patient_id
       join kenyaemr_etl.etl_default_facility_info i
where m.patient_id is not null
   or c.patient_id is not null
group by EncounterId;