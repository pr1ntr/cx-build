var coffee = require('coffee-script');
var cxappserver = require("./server/cxappserver");
var app = new cxappserver();
app.configure("../cxapp.json")
app.create();

