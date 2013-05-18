
AppModel = require '../model/AppModel'
PreloaderZed = require '../model/utils/PreloaderZed'
SocketConnection = require '../sockets/SocketConnection'


class AppMediator
    
    model = {}



    views = []
    currentView = null



    constructor: () ->

        @model = AppModel.getInstance()
        

        views = []

        



        
      

    initialize: () =>
        @socket = new SocketConnection()

        navigator.geolocation.getCurrentPosition (data) =>
            console.log data

       



    onStepChange: (view) =>
        

        view = views[view]
        console.log currentView
        if currentView isnt view
            currentView.transitionOut view.transitionIn
            currentView = view
        else
            view.transitionIn()


    











module.exports = AppMediator

