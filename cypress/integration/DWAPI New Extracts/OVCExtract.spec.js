describe("Connect and validate OVC extracts", () => {
  let res = [];
  it("Check if the OVC Extract.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/OVC Extract.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("CPIMSUniqueIdentifier");
      expect(res[0]).to.have.property("EnrolledinCPIMS");
      expect(res[0]).to.have.property("ExitDate");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("OVCEnrollmentDate");
      expect(res[0]).to.have.property("OVCExitReason");
      expect(res[0]).to.have.property("PartnerOfferingOVCServices");
      expect(res[0]).to.have.property("PatientID");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("ProgramModel");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("RelationshipToClient");
      expect(res[0]).to.have.property("VisitDate");
      expect(res[0]).to.have.property("VisitID");
      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
