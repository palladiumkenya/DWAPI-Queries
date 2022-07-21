SELECT t.patient_id                                                                as PatientPK,
       (select siteCode from kenyaemr_etl.etl_default_facility_info)               as SiteCode,
       (select FacilityName from kenyaemr_etl.etl_default_facility_info)           as FacilityName,
       'KenyaEMR'                                                                  as Emr,
       'Kenya HMIS II'                                                             as Project,
       demographics.openmrs_id                                                     as HtsNumber,
       t.visit_id                                                                  as VisitID,
       t.encounter_id                                                              as EncounterId,
       t.visit_date                                                                as VisitDate,
       case t.population_type
           when 164928 then 'General Population'
           when 164929 then 'Key Population'
           when 138643
               then 'Priority Population' end                                      as PopulationType,
       t.key_population_type                                                       as KeyPopulation,
       t.priority_population_type                                                  as PriorityPopulation,
       case t.department
           when 160542 then 'OPD:Out-patient department'
           when 5485 then 'IPD:In-patient department'
           when 160473 then 'Emergency'
           when 160538 then 'PMTCT'
           when 159940
               then 'VCT' end                                                      as Department,
       case t.patient_type
           when 164163 then 'HP:Hospital Patient'
           when 164953
               then 'NP:Non-Hospital Patient' end                                  as PatientType,
       case t.is_health_worker when 1065 then 'Yes' when 1066 then 'No' end        as IsHealthWorker,
       t.relationship_with_contact                                                 as RelationshipWithContact,
       case t.mother_hiv_status when 703 then 'Positive' when 664 then 'Negative' when 1067 then 'Unknown' end as MothersStatus,
       case t.tested_hiv_before when 1065 then 'Yes' when 1066 then 'No' end       as TestedHIVBefore,
       case t.who_performed_test
           when 5619 then 'HTS Provider'
           when 164952
               then 'Self Tested' end                                              as WhoPerformedTest,
       (case t.test_results
            when 703 then 'Positive'
            when 664 then 'Negative'
            when 1067 then 'Unknown'
            else '' end)                                                           as ResultOfHIV,
       if(t.who_performed_test = 164952,t.date_tested,null)                             as DateTestedSelf,
       if(t.who_performed_test = 164952,case t.test_results
            when 703 then 'Positive'
            when 664 then 'Negative'
            when 1067 then 'Unknown'
            else '' end,null)                                                           as ResultOfHIVSelf,
       if(t.who_performed_test = 5619,t.date_tested, null)                             as DateTestedProvider,
       case t.started_on_art when 1065 then 'Yes' when 1066 then 'No' end          as StartedOnART,
       t.upn_number                                                                as CCCNumber,
       case t.ever_had_sex when 1 then 'Yes' when 0 then 'No' end                  as EverHadSex,
       case t.sexually_active when 1065 then 'Yes' when 1066 then 'No' end         as SexuallyActive,
       case t.new_partner when 1065 then 'Yes' when 1066 then 'No' end             as NewPartner,
       (case t.partner_hiv_status
            when 703 then 'Positive'
            when 664 then 'Negative'
            when 1067 then 'Unknown'
            else '' end)                                                           as PartnerHIVStatus,
       case t.couple_discordant when 1065 then 'Yes' when 1066 then 'No' end       as CoupleDiscordant,
       case t.multiple_partners when 1 then 'Yes' when 0 then 'No' end             as MultiplePartners,
       t.number_partners                                                           as NumberOfPartners,
       case t.alcohol_sex
           when 1066 then 'Not at all'
           when 1385 then 'Sometimes'
           when 165027
               then 'Always' end                                                   as AlcoholSex,
       case t.money_sex when 1065 then 'Yes' when 1066 then 'No' end               as MoneySex,
       case t.condom_burst when 1065 then 'Yes' when 1066 then 'No' end            as CondomBurst,
       case t.unknown_status_partner when 1065 then 'Yes' when 1066 then 'No' end  as UnknownStatusPartner,
       case t.known_status_partner when 163289 then 'Yes' when 1066 then 'No' end  as KnownStatusPartner,
       case t.pregnant when 1065 then 'Yes' when 1066 then 'No' end                as Pregnant,
       case t.breastfeeding_mother when 1065 then 'Yes' when 1066 then 'No' end    as BreastfeedingMother,
       case t.experienced_gbv when 1065 then 'Yes' when 1066 then 'No' end         as ExperiencedGBV,
       t.type_of_gbv                                                               as TypeGBV,
       t.service_received                                                          as ReceivedServices,
       case t.currently_on_prep when 1065 then 'Yes' when 1066 then 'No' end       as CurrentlyOnPrEP,
       case t.recently_on_pep when 1 then 'Yes' when 0 then 'No' end              as CurrentlyOnPEP,
       case t.recently_had_sti when 1065 then 'Yes' when 1066 then 'No' end       as CurrentlyHasSTI,
       case t.tb_screened when 1065 then 'Yes' when 1066 then 'No' end  ScreenedTB,
       case t.cough when 159799 then 'Yes' when 1066 then 'No' end as Cough,
       case t.fever when 1494 then 'Yes' when 1066 then 'No' end as Fever,
       case t.weight_loss when 832 then 'Yes' when 1066 then 'No' end as WeightLoss,
       case t.night_sweats when 133027 then 'Yes' when 1066 then 'No' end as NightSweats,
       case t.contact_with_tb_case when 124068 then 'Yes' when 1066 then 'No' end as ContactWithTBCase,
       case t.lethargy when 116334 then 'Yes' when 1066 then 'No' end as Lethargy,
       case t.tb_status when 1660 then 'No TB signs' when 142177 then 'Presumed TB' when 1662 then 'TB Confirmed' end as TBStatus,
       case t.shared_needle when 1065 then 'Yes' when 1066 then 'No' end           as SharedNeedle,
       case t.needle_stick_injuries when 153574 then 'Yes' when 1066 then 'No' end as NeedleStickInjuries,
       case t.traditional_procedures when 1065 then 'Yes' when 1066 then 'No' end  as TraditionalProcedures,
       t.child_reasons_for_ineligibility                                           as ChildReasonsForIneligibility,
       case t.eligible_for_test when 1065 then 'Yes' when 1066 then 'No' end       as EligibleForTest,
       t.reasons_for_ineligibility as ReasonsForIneligibility,
       t.specific_reason_for_ineligibility                                            SpecificReasonForIneligibility,
       t.date_created                                                              as DateCreated,
       t.date_last_modified                                                        as DateLastModified
FROM kenyaemr_etl.etl_hts_eligibility_screening t
         inner join kenyaemr_etl.etl_patient_demographics demographics on t.patient_id = demographics.patient_id
         LEFT JOIN openmrs.location_attribute SC ON SC.location_id = t.location_id AND SC.attribute_type_id = 1
         LEFT JOIN openmrs.location SN ON SN.location_id = t.location_id group by t.encounter_id;
