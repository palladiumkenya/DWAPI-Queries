describe("Connect and validate HTS Client Linkage extracts", () => {
  let res = [];
  it("Check if the HTS Client Linkage.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTS Client Linkage.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("DatePrefferedToBeEnrolled");
      expect(res[0]).to.have.property("FacilityReferredTo");
      expect(res[0]).to.have.property("HandedOverTo");
      expect(res[0]).to.have.property("HandedOverToCadre");
      expect(res[0]).to.have.property("EnrolledFacilityName");
      expect(res[0]).to.have.property("ReferralDate");
      expect(res[0]).to.have.property("DateEnrolled");
      expect(res[0]).to.have.property("ReportedCCCNumber");
      expect(res[0]).to.have.property("ReportedStartARTDate");

      
      
    }
  });
});
