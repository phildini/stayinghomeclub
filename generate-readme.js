// this is the build step each time the site is updated, run this file
// with the the command: node generate-readme.js
// this will generate the README.md file with data from the json data files

const { buildAndWriteReadmeFile } = require("./src/utilities");
buildAndWriteReadmeFile("companies.json", "events.json");
