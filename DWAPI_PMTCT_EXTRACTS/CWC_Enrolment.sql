select d.patient_id              as PatientPK,
       d.openmrs_id              as PatientMNCH_ID,
       i.siteCode                as SiteCode,
       d.cwc_number              as PatientIDCWC,
       d.hei_no                  as HEIID,
       pkv.PKV                   as MothersPKV,
       e.initial_reg_at_cwc      as RegistrationAtCWC,
       e.child_exposed           as HEI,
       e.initial_reg_at_cwc      as RegistrationAtHEI,
       'KenyaEMR'                as Emr,
       'Kenya HMIS II'           as Project,
       e.visit_id                as VisitID,
       e.gestation_at_birth      as GestationAtBirth,
       round(e.birth_weight, 2)  as Birth_Weight,
       round(e.birth_length, 2)  as BirthLength,
       e.birth_order             as BirthOrder,
       e.birth_type              as BirthType,
       e.place_of_delivery       as PlaceOfdelivery,
       e.mode_of_delivery        as ModeOfDelivery,
       e.has_special_needs       as SpecialNeeds,
       e.reason_for_special_care as SpecialCare,
       e.is_mother_alive         as Mother_Alive,
       e.mother_ccc_no           as MothersCCCNo,
       e.mother_art_regimen      as MotherARTRegimen,
       e.transfer_in             as TransferIn,
       e.trf_in_date             as TransferInDate,
       e.facility_trf_from       as TransferredFromFacility,
       e.nvp_during_bf           as NVP,
       e.breast_feeding          as BreastFeeding,
       e.referred_from           as ReferredFrom
from kenyaemr_etl.etl_patient_demographics d
       inner join (select e.patient_id                                                             as patient_id,
                          e.permanent_registration_serial                                          as permanent_reg_serial,
                          min(e.visit_date)                                                        as initial_reg_at_cwc,
                          case e.child_exposed
                            when 822 then 'Yes'
                            when 1066 then 'No'
                            when 1067 then 'Unknown' end                                           as child_exposed,
                          e.visit_id                                                               as visit_id,
                          e.gestation_at_birth                                                     as gestation_at_birth,
                          e.birth_weight                                                           as birth_weight,
                          e.birth_length                                                           as birth_length,
                          e.birth_order                                                            as birth_order,
                          case e.birth_type
                            when 159913 then 'Single'
                            when 159914 then 'Twins'
                            when 159915 then 'Triplets'
                            when 113450 then 'Quadruplets'
                            when 113440 then 'Quintuplets' end                                     as birth_type,
                          case e.place_of_delivery
                            when 1589 then 'Facility'
                            when 1536 then 'Home'
                            when 5622 then 'Other' end                                             as place_of_delivery,
                          case e.mode_of_delivery
                            when 1170 then 'SVD'
                            when 1171 then 'C-Section' end                                         as mode_of_delivery,
                          case e.need_for_special_care
                            when 161628 then 'Yes'
                            when 1066 then 'No' end                                                as has_special_needs,
                          case e.reason_for_special_care
                            when 116222 then 'Birth weight less than 2.5 kg'
                            when 162071 then 'Birth less than 2 years after last birth'
                            when 162072 then 'Fifth or more child'
                            when 162073 then 'Teenage mother'
                            when 162074 then 'Brother or sisters undernourished'
                            when 162075 then 'Multiple births(Twins,triplets)'
                            when 162076 then 'Child in family dead'
                            when 1174 then 'Orphan'
                            when 161599 then 'Child has disability'
                            when 1859 then 'Parent HIV positive'
                            when 123174
                                    then 'History/signs of child abuse/neglect' end                as reason_for_special_care,
                          case e.mother_alive when 1 then 'Yes' when 0 then 'No' else '' end       as is_mother_alive,
                          e.parent_ccc_number                                                      as mother_ccc_no,
                          case e.mother_drug_regimen
                            when 792 then "D4T/3TC/NVP"
                            when 160124 then "AZT/3TC/EFV"
                            when 160104 then "D4T/3TC/EFV"
                            when 1652 then "3TC/NVP/AZT"
                            when 161361 then "EDF/3TC/EFV"
                            when 104565 then "EFV/FTC/TDF"
                            when 162201 then "3TC/LPV/TDF/r"
                            when 817 then "ABC/3TC/AZT"
                            when 162199 then "ABC/NVP/3TC"
                            when 162200 then "3TC/ABC/LPV/r"
                            when 162565 then "3TC/NVP/TDF"
                            when 1652 then "3TC/NVP/AZT"
                            when 162561 then "3TC/AZT/LPV/r"
                            when 164511 then "AZT-3TC-ATV/r"
                            when 164512 then "TDF-3TC-ATV/r"
                            when 162560 then "3TC/D4T/LPV/r"
                            when 162563 then "3TC/ABC/EFV"
                            when 162562 then "ABC/LPV/R/TDF"
                            when 162559
                                    then "ABC/DDI/LPV/r" end                                       as mother_art_regimen,
                          case e.transfer_in when 1065 then 'Yes' when 1066 then 'No' end          as transfer_in,
                          e.transfer_in_date                                                       as trf_in_date,
                          e.facility_transferred_from                                              as facility_trf_from,
                          e.mother_on_NVP_during_breastfeeding                                     as nvp_during_bf,
                          case e.mother_breastfeeding when 1065 then 'Yes' when 1066 then 'No' end as breast_feeding,
                          case e.referral_source
                            when 160537 then 'Paediatric'
                            when 160542 then 'OPD'
                            when 160456 then 'Maternity'
                            when 162050 then 'CCC'
                            when 160538 then 'MCH/PMTCT'
                            when 5622 then 'Other' end                                             as referred_from,
                          md.parent_pid                                                            as parent_pid,
                          e.date_created                                                           as Date_Created,
                          e.date_last_modified                                                     as Date_Last_Modified
                   from kenyaemr_etl.etl_hei_enrollment e
                          left join (select d.patient_id as parent_pid, d.unique_patient_no as parent_ccc
                                     from kenyaemr_etl.etl_patient_demographics d)md
                            on e.parent_ccc_number = md.parent_ccc
                   group by e.patient_id) e on d.patient_id = e.patient_id
       left join (select x.patient_id as patient_id,
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
                        FROM kenyaemr_etl.etl_patient_demographics)x)pkv on pkv.patient_id = e.parent_pid
       join kenyaemr_etl.etl_default_facility_info i;