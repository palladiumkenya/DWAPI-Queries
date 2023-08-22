describe("Connect and validate HTS Client Tracing extracts", () => {
  let res = [];
  it("Check if the HTSClients.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTSClients.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("County");
      expect(res[0]).to.have.property("DOB");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Gender");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("SiteCode");

      expect(res[0]).to.have.property("KeyPopulationType");
      expect(res[0]).to.have.property("MaritalStatus");
      expect(res[0]).to.have.property("PatientDisabled");
      expect(res[0]).to.have.property("Pkv");
      expect(res[0]).to.have.property("PopulationType");
      expect(res[0]).to.have.property("SubCounty");
      expect(res[0]).to.have.property("Ward");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("HtsNumber");
    }
  });
});
