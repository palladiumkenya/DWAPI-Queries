describe("Connect and validate MNCH_Enrolment extracts", () => {
  let res = [];
  it("Check if the MNCH_Enrolment.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/MNCH_Enrolment.sql").then(
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
      expect(res[0]).to.have.property("PatientMNCHCWC_ID");

      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("ServiceType");
      expect(res[0]).to.have.property("EnrollmentDateATMNCH");
      expect(res[0]).to.have.property("MNCHNumber");
      expect(res[0]).to.have.property("FirstVisitANC");
      expect(res[0]).to.have.property("Parity");
      expect(res[0]).to.have.property("Gravidae");
      expect(res[0]).to.have.property("LMP");
      expect(res[0]).to.have.property("EDDFromLMP");
      expect(res[0]).to.have.property("HIVStatusBeforeANC");
      expect(res[0]).to.have.property("HIVTestDate");
      expect(res[0]).to.have.property("PartnerHIVStatus");
      expect(res[0]).to.have.property("PartnerHIVTestDate");
      expect(res[0]).to.have.property("BloodGroup");
      expect(res[0]).to.have.property("StatusAtMNCH");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
