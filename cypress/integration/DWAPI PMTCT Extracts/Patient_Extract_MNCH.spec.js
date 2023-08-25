describe("Connect and validate Patient Extract MNCH extracts", () => {
  let res = [];
  it("Check if the PatientMNCH.sql will run without any error", () => {
    cy.readFile("./DWAPI PMTCT EXTRACTS/PatientMNCH.sql").then(
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
      expect(res[0]).to.have.property("PKV");
      expect(res[0]).to.have.property("PatientPK");
      expect(res[0]).to.have.property("NUPI");
      expect(res[0]).to.have.property("SiteCode");
      expect(res[0]).to.have.property("PatientMNCH_ID");
      expect(res[0]).to.have.property("PatientHEI_ID");
      expect(res[0]).to.have.property("Emr");
      expect(res[0]).to.have.property("Project");
      expect(res[0]).to.have.property("FacilityName");
      expect(res[0]).to.have.property("Gender");
      expect(res[0]).to.have.property("DOB");
      expect(res[0]).to.have.property("FirstEnrollmentAtMnch");
      expect(res[0]).to.have.property("EncounterId");
      expect(res[0]).to.have.property("Occupation");
      expect(res[0]).to.have.property("MaritalStatus");
      expect(res[0]).to.have.property("EducationLevel");
      expect(res[0]).to.have.property("PatientResidentCounty");
      expect(res[0]).to.have.property("PatientResidentSubCounty");
      expect(res[0]).to.have.property("PatientResidentWard");
      expect(res[0]).to.have.property("Inschool");

      expect(res[0]).to.have.property("Date_Created");
      expect(res[0]).to.have.property("Date_Last_Modified");
    }
  });
});
