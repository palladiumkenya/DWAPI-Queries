describe("Connect and validate CWC Enrolment extracts", () => {
  let res = [];
  it("Check if the CWC_Enrollment.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/CWC_Enrolment.sql").then(
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
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientIDCWC");
      expect(res[0]).to.have.property("HEIID");

      expect(res[0]).to.have.property("MothersPKV");
      expect(res[0]).to.have.property("RegistrationAtCWC");
      expect(res[0]).to.have.property("HEI");
      expect(res[0]).to.have.property("RegistrationAtHEI");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("GestationAtBirth");
      expect(res[0]).to.have.property("Birth_Weight");
      expect(res[0]).to.have.property("BirthLength");
      expect(res[0]).to.have.property("BirthOrder");
      expect(res[0]).to.have.property("BirthType");
      expect(res[0]).to.have.property("PlaceOfdelivery");
      expect(res[0]).to.have.property("ModeOfDelivery");
      expect(res[0]).to.have.property("SpecialNeeds");
      expect(res[0]).to.have.property("SpecialCare");
      expect(res[0]).to.have.property("Mother_Alive");
      expect(res[0]).to.have.property("MothersCCCNo");
      expect(res[0]).to.have.property("MotherARTRegimen");
      expect(res[0]).to.have.property("TransferIn");
      expect(res[0]).to.have.property("TransferInDate");
      expect(res[0]).to.have.property("TransferredFromFacility");
      expect(res[0]).to.have.property("NVP");
      expect(res[0]).to.have.property("BreastFeeding");
      expect(res[0]).to.have.property("ReferredFrom");
    }
  });
});
