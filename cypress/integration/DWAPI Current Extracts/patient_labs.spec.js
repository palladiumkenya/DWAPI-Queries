describe("Validate Patient labs extracts", () => {
  let res = [];
  it("Check if the patient_labs.sql will run without any error", () => {
    cy.readFile("./DWAPI Current Extracts/patient_labs.sql").then(
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
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("patientID");
      expect(res[0]).to.have.property("patientPK");
      expect(res[0]).to.have.property("visitID");
      expect(res[0]).to.have.property("orderedByDate");
      expect(res[0]).to.have.property("reportedByDate");
      expect(res[0]).to.have.property("reason");
      expect(res[0]).to.have.property("facilityID");
      expect(res[0]).to.have.property("siteCode");
      expect(res[0]).to.have.property("facilityName");
      expect(res[0]).to.have.property("testName");
      expect(res[0]).to.have.property("TestResult");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("date_created");

      // expect(res[0]).to.have.property("AgeARTStart");
      // expect(res[0]).to.have.property("ContactRelation");
    }
  });
});
