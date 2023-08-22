describe("Connect and validate OTZ extracts", () => {
  let res = [];
  it("Check if the OTZ.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/OTZ.sql").then((querystring) => {
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

      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("ModulesCompletedToday");
      expect(res[0]).to.have.property("ModulesPreviouslyCovered");
      expect(res[0]).to.have.property("OTZEnrollmentDate");
      expect(res[0]).to.have.property("OutcomeDate");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("Remarks");
      expect(res[0]).to.have.property("SupportGroupInvolvement");
      expect(res[0]).to.have.property("TransferInStatus");
      expect(res[0]).to.have.property("TransitionAttritionReason");

      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
