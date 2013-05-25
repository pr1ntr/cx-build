var urlParam;

//Backbone Requires
//window._ = require('underscore');
//window.Backbone = require('backbone');
//Backbone.$ = $;

//Greensock Requires
//require("./includes/greensock/TweenLite.min.js")
//require("./includes/greensock/TweenMax.min.js")
//require("./includes/greensock/easing/EasePack.min.js")


//Create JS Requires
//Required for both 
//window.createjs = window.createjs || {}; 
//Canvas Lib
//require("./includes/create/easeljs-0.5.0.min.js")
//Preloader Lib
//require("./includes/create/preload-0.3.0.min.js")







if (typeof Array.isArray !== "function") {
  Array.isArray = function(arr) {
    return Object.prototype.toString.call(arr) === "[object Array]";
  };
}

urlParam = function(name) {
  var regex, regexS, results;
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  regexS = "[\\?&]" + name + "=([^&#]*)";
  regex = new RegExp(regexS);
  results = regex.exec(window.location.href);
  if (results == null) {
    return void 0;
  } else {
    return results[1];
  }
};

if (window.console === void 0 || window.console === null) {
  window.console = {
    log: function() {},
    warn: function() {},
    fatal: function() {}
  };
}
