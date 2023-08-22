describe("Connect and validate HTS Client Tracing extracts", () => {
  let res = [];
  it("Check if the HTSClientTracing.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTSClientTracing.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("TracingType");
      expect(res[0]).to.have.property("TracingDate");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("TracingOutcome");
    }
  });
});
