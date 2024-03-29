select distinct t.patient_id                                                      as PatientPK,
                tc.uuid                                                           as uuid,
                id.identifier                                                     as HtsNumber,
                client_id                                                         as PartnerPersonId,
                contact_type                                                      as TraceType,
                encounter_date                                                    as TraceDate,
                (select FacilityName from kenyaemr_etl.etl_default_facility_info) as FacilityName,
                (select siteCode from kenyaemr_etl.etl_default_facility_info)     as SiteCode,
                'KenyaEMR'                                                        as Emr,
                'Kenya HMIS II'                                                   AS Project,
                status                                                            as TraceOutcome,
                tc.appointment_date                                               as BookingDate,
                tc.date_created                                                   as DateCreated,
                tc.date_changed                                                   as DateLastModified,
                tc.voided                                                         as voided
from kenyaemr_hiv_testing_patient_contact pc
         inner join dwapi_etl.etl_hts_test t on pc.patient_related_to = t.patient_id
         inner join kenyaemr_hiv_testing_client_trace tc on pc.id = tc.client_id
         LEFT JOIN patient_identifier id ON id.patient_id = t.patient_id AND id.identifier_type =
                                                                             (select patient_identifier_type_id
                                                                              from patient_identifier_type
                                                                              where name = 'OpenMRS ID')
         LEFT JOIN location_attribute SC ON SC.location_id = t.encounter_location AND SC.attribute_type_id = 1
         LEFT JOIN location SN ON SN.location_id = t.encounter_location;