describe("Connect and validate Immunizations extracts", () => {
  let res = [];
  it("Check if the ANC_Visits.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT Extracts/Immunizations.sql").then(
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
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("BCG");
      expect(res[0]).to.have.property("OPVAtBirth");
      expect(res[0]).to.have.property("OPV1");
      expect(res[0]).to.have.property("OPV2");
      expect(res[0]).to.have.property("OPV3");
      expect(res[0]).to.have.property("IPV");
    }
  });
});
