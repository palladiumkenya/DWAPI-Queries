describe("Connect and validate Dwapi_one_time_dump extract", () => {
  let res = [];
  it("Check if the Dwapi_one_time_dump.sql will run without any error", () => {
    cy.readFile("./DWAPI UPI Extracts/Dwapi_one_time_dump.sql").then(
      (querystring) => {
        return cy.task("queryDatabase", querystring).then((results, err) => {
          res = results;

          cy.log(results);
        });
      }
    );
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("CCCNumber");
      expect(res[0]).to.have.property("NationalId");
      expect(res[0]).to.have.property("Passport");
      expect(res[0]).to.have.property("HudumaNumber");
      expect(res[0]).to.have.property("BirthCertificateNumber");
      expect(res[0]).to.have.property("AlienIdNo");
      expect(res[0]).to.have.property("DrivingLicenseNumber");
      expect(res[0]).to.have.property("PatientClinicNumber");
      expect(res[0]).to.have.property("FirstName");
      expect(res[0]).to.have.property("MiddleName");
      expect(res[0]).to.have.property("LastName");
      expect(res[0]).to.have.property("DateOfBirth");
      expect(res[0]).to.have.property("Sex");
      expect(res[0]).to.have.property("MaritalStatus");
      expect(res[0]).to.have.property("Occupation");
      expect(res[0]).to.have.property("HighestLevelOfEducation");
      expect(res[0]).to.have.property("PhoneNumber");
      expect(res[0]).to.have.property("AlternativePhoneNumber");
      expect(res[0]).to.have.property("SpousePhoneNumber");
      expect(res[0]).to.have.property("NameOfNextOfKin");
      expect(res[0]).to.have.property("NextOfKinRelationship");
      expect(res[0]).to.have.property("NextOfKinTelNo");
      expect(res[0]).to.have.property("County");
      expect(res[0]).to.have.property("SubCounty");
      expect(res[0]).to.have.property("Ward");
      expect(res[0]).to.have.property("Location");
      expect(res[0]).to.have.property("Village");
      expect(res[0]).to.have.property("Landmark");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("MFLCode");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("FacilityID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("DateHivDiagnosisConfirmed");
      expect(res[0]).to.have.property("DateOfInitiation");
      expect(res[0]).to.have.property("LastRegimen");
      expect(res[0]).to.have.property("LastRegimenLine");
      expect(res[0]).to.have.property("TreatmentOutcome");
      expect(res[0]).to.have.property("DateOfLastEncounter");
      expect(res[0]).to.have.property("DateOfLastViralLoad");
      expect(res[0]).to.have.property("LastViralLoadResult");
      expect(res[0]).to.have.property("NextAppointmentDate");
      expect(res[0]).to.have.property("Current_On_ART");
    }
  });
});
