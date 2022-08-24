describe("Connect and validate RETENTION_ON_ART_12_MONTHS extracts", () => {
  let res = [];
  it("Check if the RETENTION_ON_ART_12_MONTHS will run without any error", () => {
    cy.readFile("./DWAPI Metrics/RETENTION_ON_ART_12_MONTHS").then(
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
      expect(res[0]).to.have.property("INDICATOR");
      expect(res[0]).to.have.property("INDICATOR_DATE");
      expect(res[0]).to.have.property("INDICATOR_VALUE");
    }
  });
});
