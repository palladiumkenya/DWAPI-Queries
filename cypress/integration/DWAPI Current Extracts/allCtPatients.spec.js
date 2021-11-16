describe("Connect and validate ALL Care Treatment Patient extracts", () => {
  let res = [];
  it("Check if the all_ct_patients.sql will run without any error", () => {
    cy.readFile("./DWAPI Current Extracts/all_ct_patients.sql").then(
      (querystring) => {
        return cy.task("queryDatabase", querystring).then((results) => {
          res = results;

          cy.log(results);
        });
      }
    );
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");
    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("ContactRelation");
      expect(res[0]).to.have.property("StatusAtTBClinic");
      expect(res[0]).to.have.property("StatusAtPMTCT");
      expect(res[0]).to.have.property("StatusATCCC");
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("FacilityId");

      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("siteCode");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("Gender");
      expect(res[0]).to.have.property("DOB");
      expect(res[0]).to.have.property("RegistrationDate");
      expect(res[0]).to.have.property("RegistrationAtCCC");
      expect(res[0]).to.have.property("RegistrationATPMTCT");
      expect(res[0]).to.have.property("RegistrationAtTBClinic");
      expect(res[0]).to.have.property("PatientSource");
      expect(res[0]).to.have.property("Region");
      expect(res[0]).to.have.property("District");
      expect(res[0]).to.have.property("Village");
      expect(res[0]).to.have.property("ContactRelation");
      expect(res[0]).to.have.property("LastVisit");
      expect(res[0]).to.have.property("MaritalStatus");
      expect(res[0]).to.have.property("EducationLevel");
      expect(res[0]).to.have.property("DateConfirmedHIVPositive");
      expect(res[0]).to.have.property("PreviousARTExposure");
      expect(res[0]).to.have.property("PreviousARTStartDate");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("PatientType");
      expect(res[0]).to.have.property("PopulationType");
      expect(res[0]).to.have.property("KeyPopulationType");
      expect(res[0]).to.have.property("Orphan");
      expect(res[0]).to.have.property("InSchool");
      expect(res[0]).to.have.property("PatientResidentCounty");
      expect(res[0]).to.have.property("PatientResidentSubCounty");
      expect(res[0]).to.have.property("PatientResidentLocation");
      expect(res[0]).to.have.property("PatientResidentSubLocation");
      expect(res[0]).to.have.property("PatientResidentWard");
      expect(res[0]).to.have.property("PatientResidentVillage");
      expect(res[0]).to.have.property("TransferInDate");
      expect(res[0]).to.have.property("date_created");
      expect(res[0]).to.have.property("date_last_modified");
    }
  });
});
