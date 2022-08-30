describe("Connect and validate ETL_REFRESH extracts", () => {
  let res = [];
  it("Check if the ETL_REFRESH.sql will run without any error", () => {
    cy.readFile("./DWAPI Metrics/ETL_REFRESH.sql").then((querystring) => {
      return cy.task("queryDatabase", querystring).then((results, err) => {
        res = results;

        cy.log(results);
      });
    });
  });

  it("Asserts the columns", () => {
    expect(res).to.be.an("array");

    if (res.length > 0 && res != undefined) {
      expect(res[0]).to.have.property("INDICATOR_NAME");
      expect(res[0]).to.have.property("INDICATOR_VALUE");
      expect(res[0]).to.have.property("INDICATOR_MONTH");
    }
  });
});
