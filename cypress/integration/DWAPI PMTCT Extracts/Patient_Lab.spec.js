describe("Connect and validate Patient Lab  extracts", () => {
  let res = [];
  it("Check if the PatientLab.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/PatientLab.sql").then(
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
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("FacilityID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property('SatelliteName');
      expect(res[0]).to.have.property('VisitID');
      expect(res[0]).to.have.property('OrderedByDate');
      expect(res[0]).to.have.property('ReportedByDate');
      expect(res[0]).to.have.property('TestName');
      expect(res[0]).to.have.property('TestResult');
      expect(res[0]).to.have.property('LabReason');
     

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
