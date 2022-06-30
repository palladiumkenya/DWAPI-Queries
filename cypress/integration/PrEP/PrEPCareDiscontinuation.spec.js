describe("Connect and validate PrEP Care Discontinuation", () => {
  let res = [];
  it("Check if the PrEPCareDiscontinuation.sql will run without any error", () => {
    cy.readFile("./PrEP/PrepCareDiscontinuation").then((querystring) => {
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
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PrEPNumber");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("ExitDate");
      expect(res[0]).to.have.property("ExitReason");
      expect(res[0]).to.have.property("DateOfLastPrepDose");
      expect(res[0]).to.have.property("DateCreated");

      expect(res[0]).to.have.property("DateModified");
    }
  });
});
