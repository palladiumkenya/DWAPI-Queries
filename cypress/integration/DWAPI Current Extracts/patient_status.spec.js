describe("Validate Patient status extracts", () => {
  let res = [];
  it("Check if the patient_status.sql will run without any error", () => {
    cy.readFile("./DWAPI Current Extracts/patient_status.sql").then(
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
      expect(res[0]).to.have.property("DateExtracted");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("ExitDate");
      expect(res[0]).to.have.property("ExitDescription");
      expect(res[0]).to.have.property("ExitReason");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("date_created");
      expect(res[0]).to.have.property("date_last_modified");
      expect(res[0]).to.have.property("siteCode");
    }
  });
});
