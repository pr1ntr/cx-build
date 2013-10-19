#Backbone Requires
window._ = require('underscore');
window.Backbone = require('backbone');
Backbone.$ = $;

#Greensock Requires
#require("./includes/greensock/TweenLite.min.js")
#require("./includes/greensock/TweenMax.min.js")
#require("./includes/greensock/easing/EasePack.min.js")


#Create JS Requires
#Canvas Lib
#require("./includes/create/easeljs-0.5.0.min.js")
#Preloader Lib
#require("./includes/create/preload-0.3.0.min.js")


window.createjs = window.createjs or {}




Router = require './com/Router.coffee'
Nav = require './com/Nav.coffee'



if typeof Array.isArray isnt "function"
  Array.isArray = (arr) ->
    Object::toString.call(arr) is "[object Array]"

    
window.urlParam = (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regexS = "[\\?&]" + name + "=([^&#]*)"
    regex = new RegExp(regexS)
    results = regex.exec(window.location.href)
    unless results?
    	undefined 
    else
   		results[1]

window.preventDefault = (e) ->
    if e.preventDefault
        e.preventDefault()
    else
        e.returnValue = false
    
 
 
if window.console is undefined or window.console is null
    window.console =
        log: ->
        warn: ->
        fatal: ->


$(document).ready ->
    console.log "Global Init"
    new Router()
    new Nav
        el: "body"

