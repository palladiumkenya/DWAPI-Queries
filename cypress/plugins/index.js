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
const crypto = require("crypto");

module.exports = (on, config) => {
  function decryptdata(data) {
    let algorithm = "aes256";
    const decipher = crypto.createDecipher(algorithm, config.env.secretkey);

    let decryptedData = decipher.update(data, "hex", "utf8");
    decryptedData += decipher.final("utf8");

    return decryptedData.toString();
  }

  function queryDatabase(query) {
    const connection = mysql.createConnection({
      host: decryptdata(config.env.host),
      user: decryptdata(config.env.user),
      password: decryptdata(config.env.password),
      database: decryptdata(config.env.database),
      port: decryptdata(config.env.port),
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
