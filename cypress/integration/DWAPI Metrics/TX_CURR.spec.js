describe("Connect and validate TX_CURR extracts", () => {
  let res = [];
  it("Check if the TX_CURR will run without any error", () => {
    cy.readFile("./DWAPI Metrics/TX_CURR").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("patient_id");
    }
  });
});
