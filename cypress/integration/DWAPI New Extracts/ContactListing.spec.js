describe("Connect and validate ContactListing extracts", () => {
  let res = [];
  it("Check if the Contact Listing Extract.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/Contact Listing Extract.sql").then(
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
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("PartnerPersonID");
      expect(res[0]).to.have.property("ContactAge");
      expect(res[0]).to.have.property("ContactMaritalStatus");
      expect(res[0]).to.have.property("RelationshipWithPatient");
      expect(res[0]).to.have.property("ScreenedForIPV");
      expect(res[0]).to.have.property("IpvScreening");
      expect(res[0]).to.have.property("IPVSCreeningOutcome");
      expect(res[0]).to.have.property("CurrentlyLivingWithIndexClient");
      expect(res[0]).to.have.property("KnowledgeOfHivStatus");
      expect(res[0]).to.have.property("PnsApproach");
      expect(res[0]).to.have.property("Date_Last_Modified");
      expect(res[0]).to.have.property("Date_Created");
    }
  });
});
