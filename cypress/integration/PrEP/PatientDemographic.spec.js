describe("Connect and validate PatientDemographic extracts", () => {
  let res = [];
  it("Check if the PatientDemographic.sql will run without any error", () => {
    cy.readFile("./PrEP/PatientDemographic").then((querystring) => {
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
      expect(res[0]).to.have.property("NUPI");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("PrEPEnrolmentDate");
      expect(res[0]).to.have.property("Sex");
      expect(res[0]).to.have.property("DateOfBirth");
      expect(res[0]).to.have.property("CountyOfBirth");
      expect(res[0]).to.have.property("County");
      expect(res[0]).to.have.property("SubCounty");
      expect(res[0]).to.have.property("Location");
      expect(res[0]).to.have.property("LandMark");
      expect(res[0]).to.have.property("Ward");
      expect(res[0]).to.have.property("ClientType");
      expect(res[0]).to.have.property("ReferralPoint");
      expect(res[0]).to.have.property("MaritalStatus");
      expect(res[0]).to.have.property("InSchool");
      expect(res[0]).to.have.property("PopulationType");
      expect(res[0]).to.have.property("KeyPopulationType");
      expect(res[0]).to.have.property("ReferredFrom");
      expect(res[0]).to.have.property("TransferIn");
      expect(res[0]).to.have.property("TransferInDate");
      expect(res[0]).to.have.property("TransferFromFacility");
      expect(res[0]).to.have.property("DateFirstInitiatedInPrEPCare");
      expect(res[0]).to.have.property("DateStartedPrEPAtTransferringFacility");
      expect(res[0]).to.have.property("ClientPreviouslyOnPrEP");
      expect(res[0]).to.have.property("PrevPrepReg");
      expect(res[0]).to.have.property("DateLastUsed_Prev");
    }
  });
});
