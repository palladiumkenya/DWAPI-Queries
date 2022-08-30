describe("Connect and validate DWAPI ONE TIME DUMP extracts", () => {
  let res = [];
  it("Check if the DWAPI ONE TIME DUMP will run without any error", () => {
    cy.readFile("./DWAPI Metrics/DWAPI_ONE_TIME_DUMP").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
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
