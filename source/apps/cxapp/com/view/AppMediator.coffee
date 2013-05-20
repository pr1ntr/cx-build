
AppModel = require '../model/AppModel'
PreloaderZed = require '../model/utils/PreloaderZed'

MapView = require './MapView'


class AppMediator
    
    model = {}



    views = []
    currentView = null
    geo = {}
    broadcaster = {}



    constructor: () ->

        @model = AppModel.getInstance()
        

        views = []

        



        
      

    initialize: () =>
       

        
        


        @map = new MapView
            el:"#map-canvas"
            model:@model

        @broadcastLocation()

    

    broadcastLocation: =>
        broadcaster = setInterval  @broadcastTick , 5000
        @broadcastTick()

    broadcastTick: =>

        navigator.geolocation.getCurrentPosition (data) =>
            @model.onUpdateGeo JSON.stringify(data.coords)
          

    initViews: =>
        


    onStepChange: (view) =>
        

        view = views[view]
        console.log currentView
        if currentView isnt view
            currentView.transitionOut view.transitionIn
            currentView = view
        else
            view.transitionIn()


    











module.exports = AppMediator

