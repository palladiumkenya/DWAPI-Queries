describe("Connect and validate MNCH_ART_Extract extracts", () => {
  let res = [];
  it("Check if the MNCH_ART_Extract.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/MNCH_ART_Extract.sql").then(
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
    console.log(res);
    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientMNCHCWC_ID");
      expect(res[0]).to.have.property("PatientHEI_ID");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("RegistrationAtCCC");
      expect(res[0]).to.have.property("StartARTDate");
      expect(res[0]).to.have.property("StartRegimen");
      expect(res[0]).to.have.property("StartRegimenLine");
      expect(res[0]).to.have.property("StatusAtCCC");
      expect(res[0]).to.have.property("DateStartedCurrentRegimen");
      expect(res[0]).to.have.property("LastRegimen");
      expect(res[0]).to.have.property("LastRegimenLine");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
