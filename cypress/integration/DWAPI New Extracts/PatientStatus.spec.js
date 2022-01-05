describe("Connect and validate Patient Status extracts", () => {
  let res = [];
  it("Check if the Patient status extract.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/Patient status extract.sql").then(
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
      if (res[0] != undefined && res[0].length > 0) {
        expect(res[0][0]).to.have.property("Date_Created");
        expect(res[0][0]).to.have.property("Date_Last_Modified");
        expect(res[0][0]).to.have.property("DeathDate");
        expect(res[0][0]).to.have.property("Emr");
        expect(res[0][0]).to.have.property("ExitDate");
        expect(res[0][0]).to.have.property("ExitDescription");
        expect(res[0][0]).to.have.property("ExitReason");
        expect(res[0][0]).to.have.property("FacilityId");
        expect(res[0][0]).to.have.property("FacilityName");
        expect(res[0][0]).to.have.property("PatientID");
        expect(res[0][0]).to.have.property("PatientPK");
        expect(res[0][0]).to.have.property("Project");
        expect(res[0][0]).to.have.property("ReEnrollmentDate");
        expect(res[0][0]).to.have.property("ReasonForDeath");
        expect(res[0][0]).to.have.property("SatelliteName");
        expect(res[0][0]).to.have.property("SiteCode");
        expect(res[0][0]).to.have.property("SpecificDeathReason");
        expect(res[0][0]).to.have.property("TOVerified");
        expect(res[0][0]).to.have.property("TOVerifiedDate");
      }
    }
  });
});
