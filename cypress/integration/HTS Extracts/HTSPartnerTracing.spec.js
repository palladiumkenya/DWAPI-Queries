describe("Connect and validate HTS Partner Tracing extracts", () => {
  let res = [];
  it("Check if the HTSPartnerTracing.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTSPartnerTracing.sql").then(
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

      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PartnerPersonId");
      expect(res[0]).to.have.property("TraceType");
      expect(res[0]).to.have.property("TraceDate");
      expect(res[0]).to.have.property("BookingDate");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("TraceOutcome");
      expect(res[0]).to.have.property("HtsNumber");
    }
  });
});
