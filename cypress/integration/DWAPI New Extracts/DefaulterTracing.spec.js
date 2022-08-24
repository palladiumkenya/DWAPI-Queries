describe("Connect and validate DefaulterTracing extracts", () => {
  let res = [];
  it("Check if the Defaulter Tracing.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/Defaulter Tracing.sql").then(
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
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("VisitId");
      expect(res[0]).to.have.property("Covid19AssessmentDate");
      expect(res[0]).to.have.property("EncounterId");
      expect(res[0]).to.have.property("TracingType");
      expect(res[0]).to.have.property("TracingOutcome");
      expect(res[0]).to.have.property("AttemptNumber");
      expect(res[0]).to.have.property("IsFinalTrace");
      expect(res[0]).to.have.property("TrueStatus");
      expect(res[0]).to.have.property("CauseOfDeath");
      expect(res[0]).to.have.property("Comments");
      expect(res[0]).to.have.property("BookingDate");
      expect(res[0]).to.have.property("DateCreated");
      expect(res[0]).to.have.property("DateModified");
    }
  });
});
