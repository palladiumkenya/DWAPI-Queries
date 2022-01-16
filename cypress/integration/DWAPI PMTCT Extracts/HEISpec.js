describe("Connect and validate HEI extracts", () => {
  let res = [];
  it("Check if the HEI.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/HEI.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");
    console.log(res);
    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("PatientHEI_ID");
      expect(res[0]).to.have.property("1stDNAPCRDate");
      expect(res[0]).to.have.property("2ndDNAPCRDate");
      expect(res[0]).to.have.property("3rdDNAPCRDate");

      expect(res[0]).to.have.property("ConfirmatoryPCRDate");
      expect(res[0]).to.have.property("BaselineVLDate");
      expect(res[0]).to.have.property("FinalAntibodyDate");
      expect(res[0]).to.have.property("1stDNAPCR");
      expect(res[0]).to.have.property("2ndDNAPCR");
      expect(res[0]).to.have.property("3rdDNAPCR");

      expect(res[0]).to.have.property("ConfirmatoryPCR");
      expect(res[0]).to.have.property("BaselineVL");
      expect(res[0]).to.have.property("FinalAntibody");
      expect(res[0]).to.have.property("HEIExitDate");
      expect(res[0]).to.have.property("HEIHIVStatus");
      expect(res[0]).to.have.property("HEIExitCriteria");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
