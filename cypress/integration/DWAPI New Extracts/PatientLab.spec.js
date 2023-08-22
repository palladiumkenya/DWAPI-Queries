describe("Connect and validate Patients Lab extracts", () => {
  let res = [];
  it("Check if the PatientsLab.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/PatientsLab.sql").then(
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
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
      expect(res[0]).to.have.property("DateSampleTaken");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("EnrollmentTest");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("OrderedByDate");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("Reason");
      expect(res[0]).to.have.property("ReportedByDate");
      expect(res[0]).to.have.property("SampleType");
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("TestName");
      expect(res[0]).to.have.property("TestResult");
      expect(res[0]).to.have.property("VisitId");
    }
  });
});
