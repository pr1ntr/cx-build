var coffee = require('coffee-script');
 






var cxappserver = require("./server/cxappserver");


var app = new cxappserver();


app.configure("../cxapp.json")
app.create()


/*
var b = new BuildJS('/source/apps/cxapp/', 'main.coffee', '/public/cxapp/js/main.js');
var c = new BuildCSS('/source/apps/cxapp/styles/', 'main.styl','/public/css/cxapp/main.css');

var app = express();
var debug = false;

var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', "*");
    res.header('Access-Control-Allow-Methods', 'GET,OPTIONS,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');

    next();
}


app.configure(function()
{
  app.set('port', process.env.PORT || 105);
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(allowCrossDomain); 
});

app.configure('development', function()
{
  debug = true;
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('staging', function()
{
  debug = false;

  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function()
{
  debug = false;
  app.use(express.basicAuth(process.env.USER, process.env.PASSWORD)); 
  app.use(express.errorHandler());
});



app.get('/css/main.css' , function (req, res)
{
  this.onBuild = function (res)
  {
    res.sendfile(path.join(__dirname, "/public/css/main.css"));
  }

  if(app.settings.env === "development" || app.settings.env === "staging")
    c.build(this.onBuild, res);
  else
    this.onBuild(res);
});



app.get('/js/main.js' , function (req,res)
{
  this.onBuild = function (res)
  {
    res.sendfile(path.join(__dirname, "/public/js/main.js"));
  }

  if(app.settings.env === "development" || app.settings.env === "staging")
    b.build(debug, this.onBuild, res);
  else
    this.onBuild(res);

});

app.get('/', function(req, res) {   res.sendfile(path.join(__dirname, "/public/index.html")); });

app.use(express.static(path.join(__dirname, '/public')));
http.createServer(app).listen(app.get('port'), function()
{
  console.log("Server Running - [Meme] - Port: %d   Mode: %s", app.get('port'), app.settings.env);
});*/
