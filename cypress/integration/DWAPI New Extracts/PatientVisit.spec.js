describe("Connect and validate Patients Visit extracts", () => {
  let res = [];
  it("Check if the Patients Visit Extract.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/Patients Visit Extract.sql").then(
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
      expect(res[0]).to.have.property("Abdomen");
      expect(res[0]).to.have.property("Adherence");
      expect(res[0]).to.have.property("AdherenceCategory");
      expect(res[0]).to.have.property("BP");
      expect(res[0]).to.have.property("Breastfeeding");
      expect(res[0]).to.have.property("CNS");
      expect(res[0]).to.have.property("CTXAdherence");
      expect(res[0]).to.have.property("CVS");
      expect(res[0]).to.have.property("Chest");
      expect(res[0]).to.have.property("ClinicalNotes");
      expect(res[0]).to.have.property("CurrentRegimen");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
      expect(res[0]).to.have.property("DifferentiatedCare");
      expect(res[0]).to.have.property("EDD");
      expect(res[0]).to.have.property("ENT");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("EverHadMenses");
      expect(res[0]).to.have.property("Eyes");

      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("FamilyPlanningMethod");
      expect(res[0]).to.have.property("GeneralExamination");
      expect(res[0]).to.have.property("Genitourinary");
      expect(res[0]).to.have.property("GestationAge");
      expect(res[0]).to.have.property("HCWConcern");
      expect(res[0]).to.have.property("Height");
      expect(res[0]).to.have.property("KeyPopulationType");
      expect(res[0]).to.have.property("LMP");
      expect(res[0]).to.have.property("Menopausal");
      expect(res[0]).to.have.property("Muac");
      expect(res[0]).to.have.property("NextAppointmentDate");
      expect(res[0]).to.have.property("NoFPReason");
      expect(res[0]).to.have.property("OI");
      expect(res[0]).to.have.property("OIDate");
      expect(res[0]).to.have.property("OxygenSaturation");

      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("PopulationType");
      expect(res[0]).to.have.property("Pregnant");
      expect(res[0]).to.have.property("ProphylaxisUsed");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("PulseRate");
      expect(res[0]).to.have.property("PwP");
      expect(res[0]).to.have.property("RespiratoryRate");
      expect(res[0]).to.have.property("SecondlineRegimenChangeDate");
      expect(res[0]).to.have.property("SecondlineRegimenChangeReason");
      expect(res[0]).to.have.property("Service");
      expect(res[0]).to.have.property("Skin");
      expect(res[0]).to.have.property("StabilityAssessment");
      expect(res[0]).to.have.property("SubstitutionFirstlineRegimenDate");
      expect(res[0]).to.have.property("SubstitutionFirstlineRegimenReason");
      expect(res[0]).to.have.property("SubstitutionSecondlineRegimenDate");
      expect(res[0]).to.have.property("SubstitutionSecondlineRegimenReason");
      expect(res[0]).to.have.property("SystemExamination");
      expect(res[0]).to.have.property("TCAReason");
      expect(res[0]).to.have.property("Temp");
      expect(res[0]).to.have.property("VisitBy");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitType");
      expect(res[0]).to.have.property("WABStage");
      expect(res[0]).to.have.property("WHOStage");
      expect(res[0]).to.have.property("Weight");
      expect(res[0]).to.have.property("VisitType");
      expect(res[0]).to.have.property("nutritional_status");

      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("SiteCode");

      expect(res[0]).to.have.property("VisitId");
    }
  });
});
