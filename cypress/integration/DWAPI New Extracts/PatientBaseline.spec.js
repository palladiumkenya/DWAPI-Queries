describe("Connect and validate Patient Baselie", () => {
  let res = [];
  it("Check if the Patientbaselines.sql will run without any error", () => {
    cy.readFile("./DWAPI New Extracts/Patientbaselines.sql").then((querystring) => {
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
      expect(res[0]).to.have.property("SatelliteName");
      expect(res[0]).to.have.property("FacilityId");
      expect(res[0]).to.have.property('PatientID');
      expect(res[0]).to.have.property('PatientPK');
      expect(res[0]).to.have.property('SiteCode');
      expect(res[0]).to.have.property('eCd4');
      expect(res[0]).to.have.property('eCd4Date');
      expect(res[0]).to.have.property('ewho');
      expect(res[0]).to.have.property('ewhodate');
      expect(res[0]).to.have.property('bCD4');
      expect(res[0]).to.have.property('bCD4Date');
      expect(res[0]).to.have.property('bWHO');
      expect(res[0]).to.have.property('bWHODate');
      expect(res[0]).to.have.property('lastwho');
      expect(res[0]).to.have.property('lastwhodate');
      expect(res[0]).to.have.property('lastcd4');
      expect(res[0]).to.have.property('lastcd4date');
      expect(res[0]).to.have.property('m6Cd4');
      expect(res[0]).to.have.property('m6Cd4Date');
      expect(res[0]).to.have.property('m12Cd4');
      expect(res[0]).to.have.property('m12Cd4Date');
      expect(res[0]).to.have.property('eWAB');
      expect(res[0]).to.have.property('eWABDate');
      expect(res[0]).to.have.property('bWAB');
      expect(res[0]).to.have.property('bWABDAte');
      expect(res[0]).to.have.property('Emr');
      expect(res[0]).to.have.property('Project');
      expect(res[0]).to.have.property('LastWaB');
      expect(res[0]).to.have.property('LastWABDate');
      expect(res[0]).to.have.property('date_created');
      expect(res[0]).to.have.property('date_last_modified');
      
    }
  });
});
