describe("Connect and validate PrEP Behaviour Risk", () => {
  let res = [];
  it("Check if the PrEPBehaviourRisk.sql will run without any error", () => {
    cy.readFile("./PrEP/PrEPBehaviourRisk").then((querystring) => {
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
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitId");
      expect(res[0]).to.have.property("SexPartnerHIVStatus");
      expect(res[0]).to.have.property("IsHIVPositivePartnerCurrentonART");
      expect(res[0]).to.have.property("IsPartnerHighRisk");
      expect(res[0]).to.have.property("PartnerARTRisk");
      expect(res[0]).to.have.property("ClientAssessments");
      expect(res[0]).to.have.property("ClientRisk");
      expect(res[0]).to.have.property("ClientWillingToTakePrEP");
      expect(res[0]).to.have.property("PrEPDeclineReason");
      expect(res[0]).to.have.property("RiskReductionEducationOffered");
      expect(res[0]).to.have.property("ReferralToOtherPrevServices");
      expect(res[0]).to.have.property("FirstEstablishPartnerStatus");
      expect(res[0]).to.have.property("PartnerEnrolledToCCC");
      expect(res[0]).to.have.property("HIVPartnerCCCNumber");
      expect(res[0]).to.have.property("HIVPartnerARTStartDate");
      expect(res[0]).to.have.property("MonthsKnownHIVSeroDiscordant");
      expect(res[0]).to.have.property("SexWithoutCondom");
      expect(res[0]).to.have.property("NumberofchildrenWithPartner");
    }
  });
});
