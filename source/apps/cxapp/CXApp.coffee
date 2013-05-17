
AppModel = require './com/model/AppModel'
AppMediator = require './com/view/AppMediator'

class CXApp

    constructor: (dataUrl)->
        #the constructor
        if dataUrl isnt undefined
            @model = AppModel.getInstance
                url: dataUrl
            @model.on "ready" , @initApp
            @model.fetch()
        else
            @initApp()
    


    initApp: =>
        @app = new AppMediator()
        @app.initialize()



module.exports = CXApp
