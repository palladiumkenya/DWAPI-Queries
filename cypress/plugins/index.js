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
//plugin
/**
 * @type {Cypress.PluginConfig}
 */
// eslint-disable-next-line no-unused-vars

const mysql = require("mysql");

module.exports = (on, config) => {
  function queryDatabase(query) {
    const connection = mysql.createConnection({
      host: config.env.host,
      user: config.env.user,
      password: config.env.password,
      database: config.env.database,
      port: config.env.port,
      connectTimeout: 100000,
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
  on("task", {
    queryDatabase: (query) => {
      return queryDatabase(query);
    },
  });

  // `on` is used to hook into various events Cypress emits
  // `config` is the resolved Cypress config
};
