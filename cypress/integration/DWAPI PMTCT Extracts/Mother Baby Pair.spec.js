describe("Connect and validate Mother Baby Pair extracts", () => {
  let res = [];
  it("Check if the MotherBabyPair.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/MotherBabyPair.sql").then(
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
      expect(res[0]).to.have.property("BabyPatientPK");
      expect(res[0]).to.have.property("MotherPatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientHEI_ID");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("PatientIDCCC");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
