describe("Connect and validate TX_PVLS extracts", () => {
  let res = [];
  it("Check if the TX_PVLS will run without any error", () => {
    cy.readFile("./DWAPI Metrics/TX_PVLS").then((querystring) => {
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
