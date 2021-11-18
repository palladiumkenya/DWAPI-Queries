describe("Validate Patient Baselines extracts", () => {
  let res = [];
  it("Check if the patient_baselines.sql will run without any error", () => {
    cy.readFile("./DWAPI Current Extracts/patient_baselines.sql").then(
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
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("LastWABDate");
      expect(res[0]).to.have.property("LastWaB");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("bCD4");
      expect(res[0]).to.have.property("bWAB");
      expect(res[0]).to.have.property("bWABDAte");
      expect(res[0]).to.have.property("bWHO");
      expect(res[0]).to.have.property("bWHODate");
      expect(res[0]).to.have.property("date_created");
      expect(res[0]).to.have.property("date_last_modified");
      expect(res[0]).to.have.property("eCd4");
      expect(res[0]).to.have.property("eCd4Date");
      expect(res[0]).to.have.property("eWAB");
      expect(res[0]).to.have.property("eWABDate");
      expect(res[0]).to.have.property("ewho");
     expect(res[0]).to.have.property("facilityId");
      expect(res[0]).to.have.property("lastcd4");
      expect(res[0]).to.have.property("lastcd4date");
      expect(res[0]).to.have.property("lastwho");
      expect(res[0]).to.have.property("lastwhodate");
      expect(res[0]).to.have.property("m6CD4");
      expect(res[0]).to.have.property("m6CD4Date");
      expect(res[0]).to.have.property("m12CD4");
      expect(res[0]).to.have.property("m12CD4Date");
      expect(res[0]).to.have.property("siteCode");

      // expect(res[0]).to.have.property("AgeARTStart");
      // expect(res[0]).to.have.property("ContactRelation");
    }
  });
});
