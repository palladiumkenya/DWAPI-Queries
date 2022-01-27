/// <reference types="cypress" />
// ***********************************************************
// This example plugins/index.js can be used to load plugins
//
// You can change the location of this file or turn off loading
// the plugins file with the 'pluginsFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/plugins-guide
// ***********************************************************

// This function is called when a project is opened or re-opened (e.g. due to
// the project's config changing)

/**
 * @type {Cypress.PluginConfig}
 */
// eslint-disable-next-line no-unused-vars

const cypress = require("cypress");
const mysql = require("mysql");
//const config = require("../../cypress.json");
function queryDatabase(query) {
  const connection = mysql.createConnection({
    host: cypress.env("host"),
    user: cypess.env("user"),
    password: cypress.env("password"),
    database: cypress.env("database"),
    port: cypress.env("port"),
    connectTimeout: 80000,
    multipleStatements: true,
  });
  connection.connect();

  return new Promise((resolve, reject) => {
    connection.query(query, (error, results, fields) => {
      if (error) {
        return reject(error);
      }

      connection.end();

      return resolve(results);
    });
  });
}

module.exports = (on, config) => {
  on("task", {
    queryDatabase: (query) => {
      return queryDatabase(query);
    },
  });

  // `on` is used to hook into various events Cypress emits
  // `config` is the resolved Cypress config
};
