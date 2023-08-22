describe("Connect and validate Patient Pharmacy extracts", () => {
  let res = [];
  it("Check if the PatientPharmacy.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/PatientPharmacy.sql").then(
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
      expect(res[0]).to.have.property("Provider");
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("siteCode");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("DispenseDate");
      expect(res[0]).to.have.property("duration");
      expect(res[0]).to.have.property("PeriodTaken");
      expect(res[0]).to.have.property("ExpectedReturn");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("TreatmentType");
      expect(res[0]).to.have.property("ProphylaxisType");
      expect(res[0]).to.have.property("DateExtracted");
      expect(res[0]).to.have.property("RegimenChangedSwitched");
      expect(res[0]).to.have.property("RegimenChangeSwitchReason");
      expect(res[0]).to.have.property("StopRegimenReason");
      expect(res[0]).to.have.property("StopRegimenDate");
      expect(res[0]).to.have.property("date_created");
      expect(res[0]).to.have.property("date_last_modified");
    }
  });
});
