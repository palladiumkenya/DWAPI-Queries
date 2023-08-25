describe("Connect and validate HTS Clients Tests extracts", () => {
  let res = [];
  it("Check if the HTSClientsTests.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTSClientsTests.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("ClientSelfTested");
      expect(res[0]).to.have.property("ClientTestedAs");
      expect(res[0]).to.have.property("Consent");
      expect(res[0]).to.have.property("CoupleDiscordant");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("EncounterId");
      expect(res[0]).to.have.property("EntryPoint");
      expect(res[0]).to.have.property("EverTestedForHiv");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("FinalTestResult");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("MonthsSinceLastTest");
      expect(res[0]).to.have.property("PatientGivenResult");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("TbScreening");
      expect(res[0]).to.have.property("TestDate");
      expect(res[0]).to.have.property("TestResult1");
      expect(res[0]).to.have.property("TestResult2");
      expect(res[0]).to.have.property("TestStrategy");
      expect(res[0]).to.have.property("TestType");
    }
  });
});
