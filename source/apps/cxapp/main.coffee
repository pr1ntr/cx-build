
window.$ = window.jQuery = require('jquery-browserify')
require('jquery-mousewheel')($)
window._ = require('underscore')
window.Backbone = require('backbone-browserify')




Backbone.setDomLibrary($)



window.createjs = window.createjs or {}



require './include/greensock/TweenMax.min'
require './include/greensock/TimelineMax.min'
require './include/greensock/easing/EasePack.min.js'





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




CXApp = require './CXApp'

$(document).ready ->
    cx = new CXApp(urlParam('data'))
    



   