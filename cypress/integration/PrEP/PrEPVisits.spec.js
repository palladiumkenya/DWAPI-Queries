describe("Connect and validate PrEPVisits extract", () => {
  let res = [];
  it("Check if the PrEPVisits.sql will run without any error", () => {
    cy.readFile("./PrEP/PrEPVisits").then((querystring) => {
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
      expect(res[0]).to.have.property("PrepNumber");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("EncounterId");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitId");
      expect(res[0]).to.have.property("BloodPressure");
      expect(res[0]).to.have.property("Tempereature");
      expect(res[0]).to.have.property("Weight");
      expect(res[0]).to.have.property("Height");
      expect(res[0]).to.have.property("STIScreening");
      expect(res[0]).to.have.property("STISymptoms");
      expect(res[0]).to.have.property("STITreated");
      expect(res[0]).to.have.property("Circumcised");
      expect(res[0]).to.have.property("VMMCReferral");
      expect(res[0]).to.have.property("LMP");
      expect(res[0]).to.have.property("MenopausalStatus");
      expect(res[0]).to.have.property("PregnantAtThisVisit");
      expect(res[0]).to.have.property("PregnancyPlanned");
      expect(res[0]).to.have.property("PregnancyEnded");
      expect(res[0]).to.have.property("PregnancyEndDate");
      expect(res[0]).to.have.property("BirthDefects");
      expect(res[0]).to.have.property("BreastFeeding");
      expect(res[0]).to.have.property("FamilyPlanningStatus");
      expect(res[0]).to.have.property("FPMethods");
      expect(res[0]).to.have.property("AdherenceDone");
      expect(res[0]).to.have.property("AdherenceOutcome");
      expect(res[0]).to.have.property("ContraindicationsPrEP");
      expect(res[0]).to.have.property("PrEPTreatmentPlan");
      expect(res[0]).to.have.property("PrEPPrescribed");
      expect(res[0]).to.have.property("RegimenPrescribed");
      expect(res[0]).to.have.property("MonthsPrescribed");
      expect(res[0]).to.have.property("CondomsIssued");
      expect(res[0]).to.have.property("Tobegivennextappointment");
      expect(res[0]).to.have.property("Reasonfornotgivingnextappointment");
      expect(res[0]).to.have.property("NextAppointment");
      expect(res[0]).to.have.property("ClinicalNotes");
      expect(res[0]).to.have.property("VaccinationForHepBStarted");
      expect(res[0]).to.have.property("TreatedForHepB");
      expect(res[0]).to.have.property("VaccinationForHepCStarted");
      expect(res[0]).to.have.property("TreatedForHepC");
      expect(res[0]).to.have.property("date_created");
      expect(res[0]).to.have.property("date_last_modified");
    }
  });
});
