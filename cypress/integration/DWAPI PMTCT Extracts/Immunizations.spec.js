describe("Connect and validate Immunizations extracts", () => {
  let res = [];
  it("Check if the Immunizations.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/Immunizations.sql").then(
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
    console.log(res);
    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("BCG");
      expect(res[0]).to.have.property("OPVAtBirth");
      expect(res[0]).to.have.property("OPV1");
      expect(res[0]).to.have.property("OPV2");
      expect(res[0]).to.have.property("OPV3");
      expect(res[0]).to.have.property("IPV");
      expect(res[0]).to.have.property("DPTHepBH1B1");
      expect(res[0]).to.have.property("DPTHepBH1B2");
      expect(res[0]).to.have.property("PCV101");
      expect(res[0]).to.have.property("PCV102");
      expect(res[0]).to.have.property("PCV103");
      expect(res[0]).to.have.property("ROTA1");
      expect(res[0]).to.have.property("MeaslesRubella1");
      expect(res[0]).to.have.property("YellowFever");
      expect(res[0]).to.have.property("MeaslesRubella2");
      expect(res[0]).to.have.property("MeaslesAt6Months");
      expect(res[0]).to.have.property("ROTA2");
      expect(res[0]).to.have.property("DateOfNextVisit");
      expect(res[0]).to.have.property("BCGScarChecked");
      expect(res[0]).to.have.property("DateChecked");
      expect(res[0]).to.have.property("DateBCGRepeated");
      expect(res[0]).to.have.property("VitaminAAt6Months");
      expect(res[0]).to.have.property("VitaminAAt1Year");
      expect(res[0]).to.have.property("VitaminAAt18Months");
      expect(res[0]).to.have.property("VitaminAAt2Years");
      expect(res[0]).to.have.property("VitaminAAt2To5Years");
      expect(res[0]).to.have.property("FullyImmunizedChild");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
