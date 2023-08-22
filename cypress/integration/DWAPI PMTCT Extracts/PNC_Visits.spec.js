describe("Connect and validate PNC Visits  extracts", () => {
  let res = [];
  it("Check if the PNCVisits.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/PNCVisits.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("PatientPK");

      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientMNCH_ID");

      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("VisitId");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("PNCRegisterNumber");
      expect(res[0]).to.have.property("PNCVisitNo");
      expect(res[0]).to.have.property("DeliveryDate");
      expect(res[0]).to.have.property("ModeOfDelivery");
      expect(res[0]).to.have.property("PlaceOfDelivery");
      expect(res[0]).to.have.property("Height");
      expect(res[0]).to.have.property("Weight");
      expect(res[0]).to.have.property("Temp");
      expect(res[0]).to.have.property("PulseRate");
      expect(res[0]).to.have.property("RespiratoryRate");
      expect(res[0]).to.have.property("OxygenSaturation");
      expect(res[0]).to.have.property("MUAC");
      expect(res[0]).to.have.property("BP");

      expect(res[0]).to.have.property("BreastExam");
      expect(res[0]).to.have.property("GeneralCondition");
      expect(res[0]).to.have.property("HasPallor");
      expect(res[0]).to.have.property("Pallor");
      expect(res[0]).to.have.property("Breast");
      expect(res[0]).to.have.property("PPH");
      expect(res[0]).to.have.property("CSScar");
      expect(res[0]).to.have.property("UterusInvolution");
      expect(res[0]).to.have.property("Episiotomy");
      expect(res[0]).to.have.property("Lochia");
      expect(res[0]).to.have.property("Fistula");
      expect(res[0]).to.have.property("MaternalComplications");
      expect(res[0]).to.have.property("TBScreening");
      expect(res[0]).to.have.property("ClientScreenedCACx");
      expect(res[0]).to.have.property("CACxScreenMethod");
      expect(res[0]).to.have.property("CACxScreenResults");
      expect(res[0]).to.have.property("PriorHIVStatus");
      expect(res[0]).to.have.property("HIVTestingDone");
      expect(res[0]).to.have.property("HIVTest_1");
      expect(res[0]).to.have.property("HIVTest_1Result");
      expect(res[0]).to.have.property("HIVTest_2");
      expect(res[0]).to.have.property("HIVTest_2Result");
      expect(res[0]).to.have.property("HIVTestFinalResult");
      expect(res[0]).to.have.property("InfantProphylaxisGiven");
      expect(res[0]).to.have.property("MotherProphylaxisGiven");
      expect(res[0]).to.have.property("CoupleCounselled");
      expect(res[0]).to.have.property("PartnerHIVTestingPNC");
      expect(res[0]).to.have.property("PartnerHIVResultPNC");
      expect(res[0]).to.have.property("CounselledOnFP");
      expect(res[0]).to.have.property("ReceivedFP");
      expect(res[0]).to.have.property("HaematinicsGiven");

      expect(res[0]).to.have.property("DeliveryOutcome");
      expect(res[0]).to.have.property("BabyCondition");
      expect(res[0]).to.have.property("BabyFeeding");
      expect(res[0]).to.have.property("UmbilicalCord");
      expect(res[0]).to.have.property("Immunization");
      expect(res[0]).to.have.property("InfantFeeding");
      expect(res[0]).to.have.property("PreventiveServices");
      expect(res[0]).to.have.property("ReferredFrom");
      expect(res[0]).to.have.property("ReferredTo");
      expect(res[0]).to.have.property("NextAppointmentPNC");
      expect(res[0]).to.have.property("ClinicalNotes");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
