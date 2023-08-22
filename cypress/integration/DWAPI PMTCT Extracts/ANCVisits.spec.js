describe("Connect and validate ANC Visits extracts", () => {
  let res = [];
  it("Check if the ANCVisits.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/ANCVisits.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("ANCClinicNumber");
      expect(res[0]).to.have.property("ANCVisitNo");
      expect(res[0]).to.have.property("AZTBabyDispense");
      expect(res[0]).to.have.property("AntenatalExercises");
      expect(res[0]).to.have.property("BP");
      expect(res[0]).to.have.property("BreastExam");
      expect(res[0]).to.have.property("CACxScreen");
      expect(res[0]).to.have.property("CACxScreenMethod");
      expect(res[0]).to.have.property("ChronicIllness");
      expect(res[0]).to.have.property("ClinicalNotes");
      expect(res[0]).to.have.property("CounselledOn");
      expect(res[0]).to.have.property("DateMotherStartedHAART");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
      expect(res[0]).to.have.property("Deworming");
      expect(res[0]).to.have.property("DiabetesTest");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("FGM");
      expect(res[0]).to.have.property("FGMComplications");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("GestationWeeks");
      expect(res[0]).to.have.property("HIVStatusBeforeANC");
      expect(res[0]).to.have.property("HIVTestFinalResult");
      expect(res[0]).to.have.property("HIVTestType");
      expect(res[0]).to.have.property("HIVTest_1");
      expect(res[0]).to.have.property("HIVTest_1Result");
      expect(res[0]).to.have.property("HIVTest_2");
      expect(res[0]).to.have.property("HIVTestingDone");
      expect(res[0]).to.have.property("Haemoglobin");
      expect(res[0]).to.have.property("Height");

      expect(res[0]).to.have.property("IronSupplementsGiven");
      expect(res[0]).to.have.property("MUAC");
      expect(res[0]).to.have.property("MalariaProphylaxis");
      expect(res[0]).to.have.property("MotherProphylaxisGiven");
      expect(res[0]).to.have.property("NVPBabyDispense");

      expect(res[0]).to.have.property("NextAppointmentANC");
      expect(res[0]).to.have.property("OxygenSaturation");
      expect(res[0]).to.have.property("PartnerHIVStatusANC");
      expect(res[0]).to.have.property("PartnerHIVTestingANC");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("PostParturmFP");
      expect(res[0]).to.have.property("PreventiveServices");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("PulseRate");
      expect(res[0]).to.have.property("ReceivedMosquitoNet");
      expect(res[0]).to.have.property("ReferralReasons");
      expect(res[0]).to.have.property("ReferredFrom");
      expect(res[0]).to.have.property("ReferredTo");
      expect(res[0]).to.have.property("RespiratoryRate");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("SyphilisTestDone");
      expect(res[0]).to.have.property("SyphilisTestResults");
      expect(res[0]).to.have.property("SyphilisTestType");
      expect(res[0]).to.have.property("SyphilisTreated");
      expect(res[0]).to.have.property("SyphilisTreatment");
      expect(res[0]).to.have.property("TBScreening");
      expect(res[0]).to.have.property("Temp");
      expect(res[0]).to.have.property("TetanusDose");
      expect(res[0]).to.have.property("UrinalysisVariables");
      expect(res[0]).to.have.property("VLDate");
      expect(res[0]).to.have.property("VLResult");
      expect(res[0]).to.have.property("VLSampleTaken");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitId");
      expect(res[0]).to.have.property("WHOStaging");
      expect(res[0]).to.have.property("Weight");
    }
  });
});
