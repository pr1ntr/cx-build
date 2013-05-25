
window._ = require('underscore')
window.Backbone = require('backbone')
window.io = require './include/socket/socket.io.js'





Backbone.$ = $



window.createjs = window.createjs or {}







if typeof Array.isArray isnt "function"
  Array.isArray = (arr) ->
    Object::toString.call(arr) is "[object Array]"

    
urlParam = (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regexS = "[\\?&]" + name + "=([^&#]*)"
    regex = new RegExp(regexS)
    results = regex.exec(window.location.href)
    unless results?
    	undefined 
    else
   		results[1]
 
 
if window.console is undefined or window.console is null
    window.console =
        log: ->
        warn: ->
        fatal: ->




CXApp = require './CXApp.coffee' 

$(document).ready ->
    console.log "fuck"
    cx = new CXApp(urlParam('data'))
    



   