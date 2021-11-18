describe("Validate Patient visit extracts", () => {
  let res = [];
  it("Check if the patient_visit.sql will run without any error", () => {
    cy.readFile("./DWAPI Current Extracts/patient_visit.sql").then(
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
    expect(res[0]).to.have.property("Adherence");
    expect(res[0]).to.have.property("AdherenceCategory");
    expect(res[0]).to.have.property("BP");
    expect(res[0]).to.have.property("DifferentiatedCare");
    expect(res[0]).to.have.property("EDD");
    expect(res[0]).to.have.property("Emr");
    expect(res[0]).to.have.property("FacilityId");
    expect(res[0]).to.have.property("FacilityName");
    expect(res[0]).to.have.property("FamilyPlanningMethod");
    expect(res[0]).to.have.property("GestationAge");
    expect(res[0]).to.have.property("Height");
    expect(res[0]).to.have.property("KeyPopulationType");
    expect(res[0]).to.have.property("LMP");
    expect(res[0]).to.have.property("NextAppointmentDate");
    expect(res[0]).to.have.property("OI");
    expect(res[0]).to.have.property("OIDate");
    expect(res[0]).to.have.property("PWP");
    expect(res[0]).to.have.property("PatientID");
    expect(res[0]).to.have.property("PatientPK");
    expect(res[0]).to.have.property("PopulationType");
    expect(res[0]).to.have.property("Pregnant");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("SatelliteName");
    expect(res[0]).to.have.property("SecondlineRegimenChangeDate");
    expect(res[0]).to.have.property("SecondlineRegimenChangeReason");
    expect(res[0]).to.have.property("Service");
    expect(res[0]).to.have.property("StabilityAssessment");
    expect(res[0]).to.have.property("SubstitutionFirstlineRegimenDate");
    expect(res[0]).to.have.property("SubstitutionFirstlineRegimenReason");
    expect(res[0]).to.have.property("SubstitutionSecondlineRegimenDate");
    expect(res[0]).to.have.property("SubstitutionSecondlineRegimenReason");
    expect(res[0]).to.have.property("VisitDate");
    expect(res[0]).to.have.property("VisitID");
    expect(res[0]).to.have.property("VisitType");
    expect(res[0]).to.have.property("WABStage");
    expect(res[0]).to.have.property("WHOStage");
    expect(res[0]).to.have.property("Weight");
    expect(res[0]).to.have.property("date_created");
    expect(res[0]).to.have.property("date_last_modified");
    expect(res[0]).to.have.property("siteCode");
    }
  });
});
