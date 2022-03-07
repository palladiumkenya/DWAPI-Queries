describe("Connect and validate IPT extracts", () => {
  let res = [];
  it("Check if the IPT.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/IPT.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("ContactsInvited");
      expect(res[0]).to.have.property("Cough");
      expect(res[0]).to.have.property("DateOfDiscontinuation");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("EvaluatedForIPT");
      expect(res[0]).to.have.property("EverOnIPT");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("Fever");
      expect(res[0]).to.have.property("ICFActionTaken");
      expect(res[0]).to.have.property("IPTClientWorkUp");
      expect(res[0]).to.have.property("IPTDiscontinuation");
      expect(res[0]).to.have.property("IndicationForIPT");
      expect(res[0]).to.have.property("Lethargy");
      expect(res[0]).to.have.property("NightSweats");
      expect(res[0]).to.have.property("NoticeableWeightLoss");
      expect(res[0]).to.have.property("OnIPT");
      expect(res[0]).to.have.property("OnTBDrugs");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("StartAntiTBs");
      expect(res[0]).to.have.property("StartIPT");
      expect(res[0]).to.have.property("TBClinicalDiagnosis");
      expect(res[0]).to.have.property("TBRxStartDate");
      expect(res[0]).to.have.property("TBScreening");
      expect(res[0]).to.have.property("TestResult");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
