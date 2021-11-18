describe("Validate Patient Adverse Events extracts", () => {
  let res = [];
  it("Check if the patient_adverse_events.sql will run without any error", () => {
    cy.readFile("./DWAPI Current Extracts/patient_adverse_events.sql").then(
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
      expect(res[0]).to.have.property("AdverseEvent");
      expect(res[0]).to.have.property("AdverseEventActionTaken");
      expect(res[0]).to.have.property("AdverseEventClinicalOutcome");
      expect(res[0]).to.have.property("AdverseEventEndDate");
      expect(res[0]).to.have.property("AdverseEventIsPregnant");
      expect(res[0]).to.have.property("AdverseEventRegimen");
      expect(res[0]).to.have.property("AdverseEventStartDate");
      expect(res[0]).to.have.property("EMR");
      expect(res[0]).to.have.property("FacilityID");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("Severity");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("date_created");
      expect(res[0]).to.have.property("date_last_modified");

      // expect(res[0]).to.have.property("AgeARTStart");
      // expect(res[0]).to.have.property("ContactRelation");
    }
  });
});
