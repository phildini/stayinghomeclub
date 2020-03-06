const fs = require("fs");

// turn a json file into a javascript object
function getParsedJSONFromFile(path) {
  let rawFile = fs.readFileSync(path);
  let parsed = JSON.parse(rawFile);
  return parsed;
}

// build the markdown for the "companies" table in the readme using parsed JSON from the companies.json file
function buildCompanyMarkdownFromParsedJSON(parsedJSON) {
  const buildCompanyRow = rowArray => {
    return `|${rowArray.join("|")}|\n`;
  };

  let md = "";

  // header row
  md += buildCompanyRow(["Company", "WFH", "Travel", "Visitors", "Events", "Updated", "Source"]);
  md += buildCompanyRow(["---", "---", "---", "---", "---", "---", "---"]);

  // other rows
  for (var i = 0; i < parsedJSON.length; i++) {
    let d = parsedJSON[i];
    md += buildCompanyRow([d.name, d.wfh, d.travel, d.visitors, d.events, d.updated, d.sources.join(", ")]);
  }

  return md;
}

// build the markdown for the "events" section of the readme using parsed JSON from the events.json file
function buildEventMarkdownFromParsedJSON(parsedJSON) {
  const buildEventRow = (title, source, note) => {
    return `- [${title}](${source}): ${note}\n`;
  };

  let md = "";

  for (var i = 0; i < parsedJSON.length; i++) {
    let d = parsedJSON[i];
    md += buildEventRow(d.title, d.source, d.note);
  }

  return md;
}

// apply the data to a template of the readme file
function buildReadmeTemplate(companiesMarkdown, eventsMarkdown, companiesCount, eventsCount) {
  const result = `
# Who's staying home because of COVID-19?

This is the running list of what in tech has been affected by COVID-19. Pull requests gratefully accepted, especially around design or data formatting or correctness.

<a name="companies"></a>
## Companies (${companiesCount})

${companiesMarkdown}

<a name="events"></a>

## Events (${eventsCount})

${eventsMarkdown}

`;
  return result;
}

// gather data from json files, build the template, write the readme file
function buildAndWriteReadmeFile(companiesPath, eventsPath) {
  const companyData = getParsedJSONFromFile(companiesPath);
  const eventData = getParsedJSONFromFile(eventsPath);
  const companiesMarkdown = buildCompanyMarkdownFromParsedJSON(companyData);
  const eventsMarkdown = buildEventMarkdownFromParsedJSON(eventData);
  const companiesCount = companyData.length;
  const eventsCount = eventData.length;
  const fileString = buildReadmeTemplate(companiesMarkdown, eventsMarkdown, companiesCount, eventsCount);
  fs.writeFile("README.md", fileString, err => {
    if (err) return console.log(err);
    console.log("Wrote File");
  });
}

module.exports = {
  buildAndWriteReadmeFile,
};
