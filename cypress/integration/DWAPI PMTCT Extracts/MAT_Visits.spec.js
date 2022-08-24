describe("Connect and validate MAT_Visits extracts", () => {
  let res = [];
  it("Check if the MAT_Visits.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/MAT_Visits.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("AdmissionNumber");
      expect(res[0]).to.have.property("ANCVisits");
      expect(res[0]).to.have.property("DateOfDelivery");
      expect(res[0]).to.have.property("DurationOfLabor");
      expect(res[0]).to.have.property("GestationAtBirth");
      expect(res[0]).to.have.property("ModeOfDelivery");
      expect(res[0]).to.have.property("PlacentaComplete");
      expect(res[0]).to.have.property("UterotonicGiven");
      expect(res[0]).to.have.property("VaginalExamination");
      expect(res[0]).to.have.property("BloodLoss");
      expect(res[0]).to.have.property("BloodLossVisual");
      expect(res[0]).to.have.property("ConditonAfterDelivery");
      expect(res[0]).to.have.property("MaternalDeath");
      expect(res[0]).to.have.property("DeliveryComplications");
      expect(res[0]).to.have.property("NoBabiesDelivered");
      expect(res[0]).to.have.property("BabyBirthNumber");
      expect(res[0]).to.have.property("SexBaby");
      expect(res[0]).to.have.property("BirthWeight");
      expect(res[0]).to.have.property("BirthOutcome");
      expect(res[0]).to.have.property("BirthWithDeformity");
      expect(res[0]).to.have.property("TetracyclineGiven");
      expect(res[0]).to.have.property("InitiatedBF");
      expect(res[0]).to.have.property("ApgarScore1");
      expect(res[0]).to.have.property("ApgarScore5");
      expect(res[0]).to.have.property("ApgarScore10");
      expect(res[0]).to.have.property("KangarooCare");
      expect(res[0]).to.have.property("ChlorhexidineAppliedOnCordStump");
      expect(res[0]).to.have.property("VitaminKGiven");
      expect(res[0]).to.have.property("StatusBabyDischarge");
      expect(res[0]).to.have.property("MotherDischargeDate");
      expect(res[0]).to.have.property("SyphilisTestResults");
      expect(res[0]).to.have.property("HIVStatusLastANC");
      expect(res[0]).to.have.property("HIVTest_1");
      expect(res[0]).to.have.property("HIV_1Results");
      expect(res[0]).to.have.property("HIVTest_2");
      expect(res[0]).to.have.property("HIVTestFinalResult");
      expect(res[0]).to.have.property("ONARTANC");
      expect(res[0]).to.have.property("BabyGivenProphylaxis");
      expect(res[0]).to.have.property("MotherGivenCTX");
      expect(res[0]).to.have.property("PartnerHIVTestingMAT");
      expect(res[0]).to.have.property("PartnerHIVStatusMAT");
      expect(res[0]).to.have.property("CounselledOn");
      expect(res[0]).to.have.property("ReferredFrom");
      expect(res[0]).to.have.property("ReferredTo");
      expect(res[0]).to.have.property("ClinicalNotes");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
