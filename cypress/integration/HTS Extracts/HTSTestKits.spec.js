describe("Connect and validate HTS Test Kits extracts", () => {
  let res = [];
  it("Check if the HTSTestKits.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTSTestKits.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("EncounterId");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("TestKitExpiry1");
      expect(res[0]).to.have.property("TestKitExpiry2");
      expect(res[0]).to.have.property("TestKitLotNumber1");
      expect(res[0]).to.have.property("TestKitLotNumber2");
      expect(res[0]).to.have.property("TestKitName1");
      expect(res[0]).to.have.property("TestKitName2");
      expect(res[0]).to.have.property("TestResult1");
      expect(res[0]).to.have.property("TestResult2");

      expect(res[0]).to.have.property("Project");

      expect(res[0]).to.have.property("HtsNumber");
    }
  });
});
