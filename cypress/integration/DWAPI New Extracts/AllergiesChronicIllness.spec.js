describe("Connect and validate Allergies and Chronic Illness extracts", () => {
  let res = [];
  it("Check if the Allergies and Chronic illnesses.sql will run without any error", () => {
    cy.readFile(
      "./DWAPI New Extracts/Allergies and Chronic Illnesses.sql"
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
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("ChronicIllness");
      expect(res[0]).to.have.property("knownAllergies");
      expect(res[0]).to.have.property("ChronicOnsetDate");
      expect(res[0]).to.have.property("knownAllergies");
      expect(res[0]).to.have.property("AllergyCausativeAgent");
      expect(res[0]).to.have.property("AllergicReaction");
      expect(res[0]).to.have.property("AllergySeverity");
      expect(res[0]).to.have.property("AllergyOnsetDate");
      expect(res[0]).to.have.property("Skin");
      expect(res[0]).to.have.property("Eyes");
      expect(res[0]).to.have.property("ENT");
      expect(res[0]).to.have.property("Chest");
      expect(res[0]).to.have.property("CVS");
      expect(res[0]).to.have.property("Abdomen");
      expect(res[0]).to.have.property("CNS");
      expect(res[0]).to.have.property("Genitourinary");

      expect(res[0]).to.have.property("Date_Last_Modified");
      expect(res[0]).to.have.property("Date_Created");
    }
  });
});
