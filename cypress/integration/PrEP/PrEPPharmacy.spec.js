describe("Connect and validate PrEPPharmacy extract", () => {
  let res = [];
  it("Check if the PrEPPharmacy.sql will run without any error", () => {
    cy.readFile("./PrEP/PrEPPharmacy").then((querystring) => {
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
      expect(res[0]).to.have.property("FacilityID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("RegimenPrescribed");
      expect(res[0]).to.have.property("DispenseDate");
      expect(res[0]).to.have.property("Duration");
      expect(res[0]).to.have.property("DateCreated");
      expect(res[0]).to.have.property("DateModified");
      
    }
  });
});
