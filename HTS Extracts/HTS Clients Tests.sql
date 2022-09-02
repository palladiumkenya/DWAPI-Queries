SELECT t.patient_id                                                      as PatientPK,
       (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
       (select siteCode from kenyaemr_etl.etl_default_facility_info)     as SiteCode,
       'KenyaEMR'                                                        as Emr,
       'Kenya HMIS II'                                                   AS Project,
       demographics.openmrs_id                                           AS HtsNumber,
       t.encounter_id                                                    as EncounterId,
       t.visit_date                                                      as TestDate,
       t.ever_tested_for_hiv                                             as EverTestedForHiv,
       t.months_since_last_test                                          as MonthsSinceLastTest,
       t.client_tested_as                                                as ClientTestedAs,
       case t.hts_entry_point
           when 5485 then "In Patient Department(IPD)"
           when 160542 then "Out Patient Department(OPD)"
           when 162181 then "Peadiatric Clinic"
           when 160552 then "Nutrition Clinic"
           when 160538 then "PMTCT ANC"
           when 160456 then "PMTCT MAT"
           when 1623 then "PMTCT PNC"
           when 160541 then "TB"
           when 162050 then "CCC"
           when 159940 then "VCT"
           when 159938 then "Home Based Testing"
           when 159939 then "Mobile Outreach"
           when 162223 then "VMMC"
           when 160546 then "STI Clinic"
           when 160522 then "Emergency"
           when 163096 then "Community Testing"
           when 5622 then "Other" end                                    as EntryPoint,
       case t.test_strategy
           when 164163 then "HP: Hospital Patient Testing"
           when 164953 then "NP: HTS for non-patients"
           when 164954 then "VI:Integrated VCT Center"
           when 164955 then "VS:Stand Alone VCT Center"
           when 159938 then "HB:Home Based Testing"
           when 159939 then "MO: Mobile Outreach HTS"
           when 161557 then "Index testing"
           when 166606 then "SNS - Social Networks"
           when 5622 then "O:Other"
           end                                                           as TestStrategy,
       t.test_1_result                                                   as TestResult1,
       t.test_2_result                                                   as TestResult2,
       t.final_test_result                                               as FinalTestResult,
       t.patient_given_result                                            as PatientGivenResult,
       t.tb_screening                                                    as TbScreening,
       t.patient_had_hiv_self_test                                       as ClientSelfTested,
       t.couple_discordant                                               as CoupleDiscordant,
       CASE t.test_type
           WHEN 1 THEN 'Initial'
           WHEN 2 THEN 'Repeat'
           END                                                           AS TestType,
       t.patient_consented                                               as Consent,
       t.date_created                                                    as Date_Created,
       t.date_last_modified                                              as Date_Last_Modified
FROM kenyaemr_etl.etl_hts_test t
         inner join kenyaemr_etl.etl_patient_demographics demographics on t.patient_id = demographics.patient_id;