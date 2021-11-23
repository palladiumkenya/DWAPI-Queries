describe("Connect and validate Enhanced Adherence extracts", () => {
  let res = [];
  it("Check if the Enhanaced Adherence Screening Extract.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/Enhanced Adherence Extract.sql").then(
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
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("SessionNumber");
      expect(res[0]).to.have.property("DateOfFirstSession");
      expect(res[0]).to.have.property("PillCountAdherence");
      expect(res[0]).to.have.property("MMAS4_1");
      expect(res[0]).to.have.property("MMAS4_2");
      expect(res[0]).to.have.property("MMAS4_3");
      expect(res[0]).to.have.property("MMAS4_4");
      expect(res[0]).to.have.property("MMSA8_1");
      expect(res[0]).to.have.property("MMSA8_2");
      expect(res[0]).to.have.property("MMSA8_3");
      expect(res[0]).to.have.property("MMSA8_4");
      expect(res[0]).to.have.property("MMSAScore");
      expect(res[0]).to.have.property("EACRecievedVL");
      expect(res[0]).to.have.property("EACVL");
      expect(res[0]).to.have.property("EACVLConcerns");
      expect(res[0]).to.have.property("EACVLThoughts");
      expect(res[0]).to.have.property("EACWayForward");
      expect(res[0]).to.have.property("EACAdherencePlan");
      expect(res[0]).to.have.property("EACBehaviouralBarrier_1");
      expect(res[0]).to.have.property("EACBehaviouralBarrier_2");
      expect(res[0]).to.have.property("EACBehaviouralBarrier_3");
      expect(res[0]).to.have.property("EACBehaviouralBarrier_4");
      expect(res[0]).to.have.property("EACBehaviouralBarrier_5");
      expect(res[0]).to.have.property("EACCognitiveBarrier");
      expect(res[0]).to.have.property("EACEconBarrier_1");
      expect(res[0]).to.have.property("EACEconBarrier_2");
      expect(res[0]).to.have.property("EACEconBarrier_3");
      expect(res[0]).to.have.property("EACEconBarrier_4");
      expect(res[0]).to.have.property("EACEconBarrier_5");
      expect(res[0]).to.have.property("EACEconBarrier_6");
      expect(res[0]).to.have.property("EACEconBarrier_7");
      expect(res[0]).to.have.property("EACEconBarrier_8");
      expect(res[0]).to.have.property("EACEmotionalBarriers_1");
      expect(res[0]).to.have.property("EACEmotionalBarriers_2");
      expect(res[0]).to.have.property("EACFollowupDate");
      expect(res[0]).to.have.property("EACHomevisit");
      expect(res[0]).to.have.property("EACRecievedVL");
      expect(res[0]).to.have.property("EACReferral");
      expect(res[0]).to.have.property("EACReferralApp");
      expect(res[0]).to.have.property("EACReferralExperience");
      expect(res[0]).to.have.property("EACReviewImprovement");
      expect(res[0]).to.have.property("EACReviewMissedDoses");
      expect(res[0]).to.have.property("EACReviewStrategy");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
