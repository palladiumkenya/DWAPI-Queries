describe("Connect and validate Drug and Alcohol Screening  extracts", () => {
  let res = [];
  it("Check if the Drug and Alcohol Screening Extract.sql will run without any error", () => {
    cy.readFile(
      "./DWAPI New Extracts/Drug and Alcohol Screening Extract.sql"
    ).then((querystring) => {
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
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("DrinkingAlcohol");
      expect(res[0]).to.have.property("Smoking");
      expect(res[0]).to.have.property("DrugUse");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
