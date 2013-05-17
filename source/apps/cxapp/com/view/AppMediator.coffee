
AppModel = require '../model/AppModel'
PreloaderZed = require '../model/utils/PreloaderZed'



class AppMediator
    
    model = {}



    views = []
    currentView = null



    constructor: () ->

        @model = AppModel.getInstance()
        

        views = []

        



        
      

    initialize: () =>


       



    onStepChange: (view) =>
        

        view = views[view]
        console.log currentView
        if currentView isnt view
            currentView.transitionOut view.transitionIn
            currentView = view
        else
            view.transitionIn()


    











module.exports = AppMediator

