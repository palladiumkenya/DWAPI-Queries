describe("Connect and validate covid extracts", () => {
  it("Check if the database exist", () => {
    cy.task(
      "queryDatabase",
      `select schema_name from information_schema.schemata where schema_name like 'kenyaemr_etl'`
    ).then((count) => {
      expect(count).to.have.lengthOf(1);
    });
  });

  it("Check if the etl_patient_demographics table exist", () => {
    cy.task(
      "queryDatabase",
      `select * from information_schema.tables where table_schema='kenyaemr_etl'
and table_name='etl_patient_demographics'`
    ).then((count) => {
      expect(count).to.have.lengthOf(1);
    });
  });

  it("Check if the etl_covid19_assessment table exist", () => {
    cy.task(
      "queryDatabase",
      `select * from information_schema.tables where table_schema='kenyaemr_etl'
and table_name='etl_covid19_assessment'`
    ).then((count) => {
      expect(count).to.have.lengthOf(1);
    });
  });

  it("Check if the etl_default_facility_info table exist", () => {
    cy.task(
      "queryDatabase",
      `select * from information_schema.tables where table_schema='kenyaemr_etl'
and table_name='etl_default_facility_info'`
    ).then((count) => {
      expect(count).to.have.lengthOf(1);
      console.log(count);
    });
  });

  it("Check if the needed columns exist for etl_patient_demographics table", () => {
    cy.task(
      "queryDatabase",
      `select * from information_schema.columns where table_schema='kenyaemr_etl'
and table_name='etl_patient_demographics' and column_name in('openmrs_id','unique_patient_no') `
    ).then((res) => {
      let openmrsid = res.filter((e) => {
        console.log(e);
        return e.COLUMN_NAME === "openmrs_id";
      });
      let uniquepatientno = res.filter((e) => {
        console.log(e);
        return e.COLUMN_NAME === "unique_patient_no";
      });

      expect(openmrsid[0].COLUMN_NAME).to.have.string("openmrs_id");
      expect(uniquepatientno[0].COLUMN_NAME).to.have.string(
        "unique_patient_no"
      );
      //expect(count).to.have.lengthOf(1);
    });
  });

  it("Check if the needed columns exist  for etl_default_facility_info table", () => {
    cy.task(
      "queryDatabase",
      `select * from information_schema.columns where table_schema='kenyaemr_etl'
and table_name='etl_default_facility_info' and column_name in('siteCode','facilityName') `
    ).then((res) => {
      let sitecode = res.filter((e) => {
        console.log(e);
        return e.COLUMN_NAME === "siteCode";
      });
      let facilityname = res.filter((e) => {
        console.log(e);
        return e.COLUMN_NAME === "FacilityName";
      });

      expect(sitecode[0].COLUMN_NAME).to.have.string("siteCode");
      expect(facilityname[0].COLUMN_NAME).to.have.string("FacilityName");
      //expect(count).to.have.lengthOf(1);
    });
  });

  it("Check if the needed columns exist for elt_covid19_assessment table", () => {
    cy.task(
      "queryDatabase",
      `select * from information_schema.columns where table_schema='kenyaemr_etl'
and table_name='etl_covid19_assessment' 
  and column_name in('visit_id','visit_date','final_vaccination_status','first_dose_date','first_vaccine_type', 'second_dose_date','second_vaccine_type','first_vaccination_verified','second_vaccination_verified','ever_received_booster',
  'booster_vaccine_taken','date_taken_booster_vaccine'
  ,'booster_sequence','ever_tested_covid_19_positive'
  ,'booster_dose_verified' ,
  'date_tested_positive','symptomatic'
  ,'hospital_admission','admission_unit' ,
  'on_oxygen_supplement','on_ventillator',
  'date_created' ,'date_last_modified')
  `
    ).then((result) => {
      const res = result;

      let visitid = res.filter((e) => {
        return e.COLUMN_NAME === "visit_id";
      });
      let visitdate = res.filter((e) => {
        return e.COLUMN_NAME === "visit_date";
      });
      let finalvaccinationstatus = res.filter((e) => {
        return e.COLUMN_NAME == "final_vaccination_status";
      });
      let firstdosedate = res.filter((e) => {
        return e.COLUMN_NAME == "first_dose_date";
      });
      let firstvaccinetype = res.filter((e) => {
        return e.COLUMN_NAME == "first_vaccine_type";
      });
      let secondvaccinetype = res.filter((e) => {
        return e.COLUMN_NAME == "second_vaccine_type";
      });
      let firstvaccinationverified = res.filter((e) => {
        return e.COLUMN_NAME == "first_vaccination_verified";
      });
      let secondvaccinationverified = res.filter((e) => {
        return e.COLUMN_NAME == "second_vaccination_verified";
      });
      let everreceivedbooster = res.filter((e) => {
        return e.COLUMN_NAME == "ever_received_booster";
      });

      let boostervaccinetaken = res.filter((e) => {
        return e.COLUMN_NAME == "booster_vaccine_taken";
      });

      let datetakenboostervaccine = res.filter((e) => {
        return e.COLUMN_NAME == "date_taken_booster_vaccine";
      });

      let boostersequence = res.filter((e) => {
        return e.COLUMN_NAME == "booster_sequence";
      });

      let evertestedcovid19sequence = res.filter((e) => {
        return e.COLUMN_NAME == "ever_tested_covid_19_positive";
      });
      let boosterdoseverified = res.filter((e) => {
        return e.COLUMN_NAME == "booster_dose_verified";
      });
      let datetestedpositive = res.filter((e) => {
        return e.COLUMN_NAME == "date_tested_positive";
      });

      let symptomatic = res.filter((e) => {
        return e.COLUMN_NAME == "symptomatic";
      });

      let hospitaladmission = res.filter((e) => {
        return e.COLUMN_NAME == "hospital_admission";
      });

      let admissionunit = res.filter((e) => {
        return e.COLUMN_NAME == "admission_unit";
      });

      let onoxygensupplement = res.filter((e) => {
        return e.COLUMN_NAME == "on_oxygen_supplement";
      });

      let onventillator = res.filter((e) => {
        return e.COLUMN_NAME == "on_ventillator";
      });

      let datecreated = res.filter((e) => {
        return e.COLUMN_NAME == "date_created";
      });

      let datelastmodified = res.filter((e) => {
        return e.COLUMN_NAME == "date_last_modified";
      });

      expect(visitid[0].COLUMN_NAME).to.have.string("visit_id");
      expect(visitdate[0].COLUMN_NAME).to.have.string("visit_date");
      expect(finalvaccinationstatus[0].COLUMN_NAME).to.have.string(
        "final_vaccination_status"
      );
      expect(firstdosedate[0].COLUMN_NAME).to.have.string("first_dose_date");
      expect(firstvaccinetype[0].COLUMN_NAME).to.have.string(
        "first_vaccine_type"
      );
      expect(secondvaccinetype[0].COLUMN_NAME).to.have.string(
        "second_vaccine_type"
      );
      expect(firstvaccinationverified[0].COLUMN_NAME).to.have.string(
        "first_vaccination_verified"
      );
      expect(secondvaccinationverified[0].COLUMN_NAME).to.have.string(
        "second_vaccination_verified"
      );
      expect(everreceivedbooster[0].COLUMN_NAME).to.have.string(
        "ever_received_booster"
      );
      expect(boostervaccinetaken[0].COLUMN_NAME).to.have.string(
        "booster_vaccine_taken"
      );
      expect(datetakenboostervaccine[0].COLUMN_NAME).to.have.string(
        "date_taken_booster_vaccine"
      );
      expect(boostersequence[0].COLUMN_NAME).to.have.string("booster_sequence");
      expect(evertestedcovid19sequence[0].COLUMN_NAME).to.have.string(
        "ever_tested_covid_19_positive"
      );
      expect(boosterdoseverified[0].COLUMN_NAME).to.have.string(
        "booster_dose_verified"
      );
      expect(datetestedpositive[0].COLUMN_NAME).to.have.string(
        "date_tested_positive"
      );
      expect(symptomatic[0].COLUMN_NAME).to.have.string("symptomatic");

      expect(hospitaladmission[0].COLUMN_NAME).to.have.string(
        "hospital_admission"
      );

      expect(admissionunit[0].COLUMN_NAME).to.have.string("admission_unit");

      expect(onoxygensupplement[0].COLUMN_NAME).to.have.string(
        "on_oxygen_supplement"
      );

      expect(onventillator[0].COLUMN_NAME).to.have.string("on_ventillator");

      expect(datecreated[0].COLUMN_NAME).to.have.string("date_created");

      expect(datelastmodified[0].COLUMN_NAME).to.have.string(
        "date_last_modified"
      );

      //expect(count).to.have.lengthOf(1);
    });
  });

  it("Check if the Covid_19.sql will not have an error", () => {
    cy.readFile("./Covid-19/Covid-19.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((count) => {
        expect(count).to.be.an("array");
      });
    });
  });
});
