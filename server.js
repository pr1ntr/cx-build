var coffee = require('coffee-script');
var cxappserver = require("./server/cxappserver");
var app = new cxappserver();

var data = "../cxapp.json" 

if(process.env.APP_DATA !== undefined){
    data = process.env.APP_DATA
}

console.log(data)

app.configure(data);
app.create();

