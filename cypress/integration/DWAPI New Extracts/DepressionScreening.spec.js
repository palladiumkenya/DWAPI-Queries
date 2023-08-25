describe("Connect and validate DepressionScreening extracts", () => {
  let res = [];
  it("Check if the DepressionScreening.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/DepressionScreening.sql").then(
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
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("PHQ9_1");
      expect(res[0]).to.have.property("PHQ9_2");
      expect(res[0]).to.have.property("PHQ9_3");
      expect(res[0]).to.have.property("PHQ9_4");
      expect(res[0]).to.have.property("PHQ9_5");
      expect(res[0]).to.have.property("PHQ9_6");
      expect(res[0]).to.have.property("PHQ9_7");
      expect(res[0]).to.have.property("PHQ9_8");
      expect(res[0]).to.have.property("PHQ9_9");
      expect(res[0]).to.have.property("DepressionAssessmentScore");
      expect(res[0]).to.have.property("PHQ_9_rating");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
