describe("Connect and validate Gender Violence extracts", () => {
  let res = [];
  it("Check if the Gender based violence Extract.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/GenderbasedViolence.sql").then(
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

      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("IPV");
      expect(res[0]).to.have.property("PhysicalIPV");
      expect(res[0]).to.have.property("EmotionalIPV");
      expect(res[0]).to.have.property("SexualIPV");
      expect(res[0]).to.have.property("IPVRelationship");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
