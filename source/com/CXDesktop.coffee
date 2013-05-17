
AppModel = require './model/AppModel'
AppMediator = require './view/AppMediator'

class MemeGenerator

    constructor: ->
        #the constructor

        @model = AppModel.getInstance
            url: "/data/data.json"
        @model.on "ready" , @initApp
        @model.fetch()
    


    initApp: =>
        @app = new AppMediator()
        @app.initialize()



module.exports = MemeGenerator
