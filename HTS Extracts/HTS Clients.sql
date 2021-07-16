SELECT distinct d.patient_id                                                      as PatientPK,
                pkv.PKV                                                           as Pkv,
                (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
                (select siteCode from kenyaemr_etl.etl_default_facility_info)     as SiteCode,
                'KenyaEMR'                                                        as Emr,
                'Kenya HMIS II'                                                   AS Project,
                id.identifier                                                     AS HtsNumber,
                d.DOB,
                case when d.Gender = 'M' then 'Male' else 'Female' end            as Gender,
                d.marital_status                                                  as MaritalStatus,
                t.population_type                                                 as PopulationType,
                t.key_population_type                                             as KeyPopulationType,
                t.disability_type                                                 as PatientDisabled,
                A.county_district                                                 as County,
                A.state_province                                                  as SubCounty,
                A.address4                                                        as Ward
FROM kenyaemr_etl.etl_patient_demographics d
       INNER JOIN kenyaemr_etl.etl_hts_test t ON d.patient_id = t.patient_id
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
       LEFT JOIN location_attribute SC ON SC.location_id = t.encounter_location AND SC.attribute_type_id = 1
       LEFT JOIN location SN ON SN.location_id = t.encounter_location
       LEFT JOIN person_address A ON A.person_id = d.patient_id
       LEFT JOIN patient_identifier id ON id.patient_id = t.patient_id AND id.identifier_type =
                                                                           (select patient_identifier_type_id
                                                                            from patient_identifier_type
                                                                            where name = 'OpenMRS ID')
group by d.patient_id;