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
       t.date_tested                                                               as DateTested,
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
       case t.physical_violence when 1065 then 'Yes' when 1066 then 'No' end       as PhysicalViolence,
       case t.sexual_violence when 1065 then 'Yes' when 1066 then 'No' end         as SexualViolence,
       case t.ever_on_prep when 1065 then 'Yes' when 1066 then 'No' end            as EverOnPrEP,
       case t.currently_on_prep when 1065 then 'Yes' when 1066 then 'No' end       as CurrentlyOnPrEP,
       case t.ever_on_pep when 1065 then 'Yes' when 1066 then 'No' end             as EverOnPEP,
       case t.currently_on_pep when 1 then 'Yes' when 0 then 'No' end              as CurrentlyOnPEP,
       case t.ever_had_sti when 1065 then 'Yes' when 1066 then 'No' end            as EverHadSTI,
       case t.currently_has_sti when 1065 then 'Yes' when 1066 then 'No' end       as CurrentlyHasSTI,
       case t.ever_had_tb when 1065 then 'Yes' when 1066 then 'No' end             as EverHadTB,
       case t.currently_has_tb when 1065 then 'Yes' when 1066 then 'No' end        as CurrentlyHasTB,
       case t.shared_needle when 1065 then 'Yes' when 1066 then 'No' end           as SharedNeedle,
       case t.needle_stick_injuries when 153574 then 'Yes' when 1066 then 'No' end as NeedleStickInjuries,
       case t.traditional_procedures when 1065 then 'Yes' when 1066 then 'No' end  as TraditionalProcedures,
       t.child_reasons_for_ineligibility                                           as ChildReasonsForIneligibility,
       case t.eligible_for_test when 1065 then 'Yes' when 1066 then 'No' end       as EligibleForTest,
       t.reasons_for_ineligibility,
       t.specific_reason_for_ineligibility                                            SpecificReasonForIneligibility,
       t.date_created                                                              as DateCreated,
       t.date_last_modified                                                        as DateLastModified
FROM kenyaemr_etl.etl_hts_eligibility_screening t
         inner join kenyaemr_etl.etl_patient_demographics demographics on t.patient_id = demographics.patient_id
         LEFT JOIN openmrs.location_attribute SC ON SC.location_id = t.location_id AND SC.attribute_type_id = 1
         LEFT JOIN openmrs.location SN ON SN.location_id = t.location_id;