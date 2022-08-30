describe("Connect and validate HTS_INDEX extracts", () => {
  let res = [];
  it("Check if the HTS_INDEX will run without any error", () => {
    cy.readFile("./DWAPI Metrics/HTS_INDEX").then((querystring) => {
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
      expect(res[0]).to.have.property("INDICATOR_VALUE");
      expect(res[0]).to.have.property("INDICATOR_DATE");
    }
  });
});
