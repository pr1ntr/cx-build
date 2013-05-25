var coffee = require('coffee-script');
var cxappserver = require("./server/cxappserver");
var app = new cxappserver();


if(process.env.APP_DATA !== undefined){
    data = process.env.APP_DATA
}



app.configure("../"+data);
app.create();

