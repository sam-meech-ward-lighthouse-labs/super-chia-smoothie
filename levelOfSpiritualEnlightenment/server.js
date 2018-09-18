let express = require('express');
let bodyParser = require('body-parser');
let ParseServer = require('parse-server').ParseServer;

var ParseDashboard = require('parse-dashboard');

let app = express();

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json());

var api = new ParseServer({
  databaseURI: 'mongodb://localhost:27017/dev', // Connection string for your MongoDB database
  appId: 'myAppId',
  masterKey: 'myMasterKey', // Keep this key secret!
  fileKey: 'optionalFileKey',
  serverURL: 'http://localhost:3000/parse' // Don't forget to change to https if needed
});

app.use('/parse', api);

var dashboard = new ParseDashboard({
  "apps": [
    {
      "serverURL": "http://localhost:3000/parse",
      "appId": "myAppId",
      "masterKey": "myMasterKey",
      "appName": "SuperChiaSmoothie"
    }
  ]
});

app.use('/dashboard', dashboard);



///////////
// Everything below is custom data persistance
//////////

let levelOfSpiritualEnlightenments = [];


app.get("/", (request, response) => {
  response.send("<html><head></head><body><h1>🤗</h1></body></html>");
});

app.get("/levelOfSpiritualEnlightenment", (request, response) => {
  // any get request to levelOfSpiritualEnlightenment handled here
  // return levelOfSpiritualEnlightenments
  response.send(levelOfSpiritualEnlightenments);
});

app.post("/levelOfSpiritualEnlightenment", (request, response) => {
  console.log(request.body);
  levelOfSpiritualEnlightenments.push(request.body.levelOfSpiritualEnlightenment);
  // append to levelOfSpiritualEnlightenments
  response.send("🤗");
});

app.listen(3000, () => {
  console.log("Listening on port 3000");
});