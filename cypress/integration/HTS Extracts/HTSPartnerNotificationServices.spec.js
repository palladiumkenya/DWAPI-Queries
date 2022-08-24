describe("Connect and validate HTS Partner Notification Services extracts", () => {
  let res = [];
  it("Check if the HTS Partner Notification Services.sql will run without any error", () => {
    cy.readFile("./HTS Extracts/HTS Partner Notification Services.sql").then(
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
      expect(res[0]).to.have.property("Emr");

      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("SiteCode");

      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("HtsNumber");
      expect(res[0]).to.have.property("PartnerPatientPk");
      expect(res[0]).to.have.property("PartnerPersonId");
      expect(res[0]).to.have.property("Age");
      expect(res[0]).to.have.property("RelationsipToIndexClient");
      expect(res[0]).to.have.property("ScreenedForIpv");
      expect(res[0]).to.have.property("IpvScreeningOutcome");
      expect(res[0]).to.have.property("CurrentlyLivingWithIndexClient");
      expect(res[0]).to.have.property("KnowledgeOfHivStatus");
      expect(res[0]).to.have.property("PnsApproach");
      expect(res[0]).to.have.property("LinkedToCare");
      expect(res[0]).to.have.property("LinkDateLinkedToCare");
      expect(res[0]).to.have.property("CccNumber");
      expect(res[0]).to.have.property("FacilityLinkedTo");
      expect(res[0]).to.have.property("DoB");
      expect(res[0]).to.have.property("DateElicited");
      expect(res[0]).to.have.property("MaritalStatus");
    }
  });
});
