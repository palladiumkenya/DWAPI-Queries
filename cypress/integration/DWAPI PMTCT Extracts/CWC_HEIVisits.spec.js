describe("Connect and validate CWC HEI  Visit extracts", () => {
  let res = [];
  it("Check if the CWH HEI Visits.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/CWCHEIVisits.sql").then(
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
    console.log(res);
    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("Height");
      expect(res[0]).to.have.property("Weight");
      expect(res[0]).to.have.property("Temp");
      expect(res[0]).to.have.property("PulseRate");
      expect(res[0]).to.have.property("RespiratoryRate");
      expect(res[0]).to.have.property("OxygenSaturation");
      expect(res[0]).to.have.property("MUAC");
      expect(res[0]).to.have.property("WeightCategory");
      expect(res[0]).to.have.property("Stunted");
      expect(res[0]).to.have.property("InfantFeeding");
      expect(res[0]).to.have.property("MedicationGiven");
      expect(res[0]).to.have.property("TBAssessment");
      expect(res[0]).to.have.property("MNPsSupplementation");
      expect(res[0]).to.have.property("Immunization");
      expect(res[0]).to.have.property("ImmunizationGiven");
      expect(res[0]).to.have.property("DangerSigns");
      expect(res[0]).to.have.property("Milestones");
      expect(res[0]).to.have.property("VitaminA");
      expect(res[0]).to.have.property("Disability");
      expect(res[0]).to.have.property("ReceivedMosquitoNet");
      expect(res[0]).to.have.property("Dewormed");
      expect(res[0]).to.have.property("ReferredFrom");
      expect(res[0]).to.have.property("ReferredTo");
      expect(res[0]).to.have.property("ReferralReasons");
      expect(res[0]).to.have.property("FollowUP");
      expect(res[0]).to.have.property("NextAppointment");
      expect(res[0]).to.have.property("dnapcr");
      expect(res[0]).to.have.property("dnapcrdate");
    }
  });
});
