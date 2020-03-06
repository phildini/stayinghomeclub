const fs = require("fs");

let raw = fs.readFileSync("companies.json");
let parsed = JSON.parse(raw);

const buildRow = rowArray => {
  return `|${rowArray.join("|")}|\r`;
};

let md = buildRow(["Company", "WFH", "Travel", "Visitors", "Events", "Source", "Updated"]);
md += buildRow(["---", "---", "---", "---", "---", "---", "---"]);

for (var i = 0; i < parsed.length; i++) {
  let d = parsed[i];
  md += buildRow([d.name, d.wfh, d.travel, d.visitors, d.events, d.updated, d.sources.join(", ")]);
}

console.log(md);
