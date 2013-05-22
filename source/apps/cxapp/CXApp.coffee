
AppModel = require './com/model/AppModel.coffee'
AppMediator = require './com/view/AppMediator.coffee'


class CXApp

    constructor: (dataUrl)->
        #the constructor

     
        if dataUrl isnt undefined
            @model = AppModel.getInstance
                url: dataUrl 
            @model.on "ready" , @initApp
            @model.fetch()
        else
            @model = AppModel.getInstance
                url: "/cxapp/data/data.json"
            @model.on "ready" , @initApp
            @model.fetch()
    


    initApp: =>

        console.log "fuck" 
        @app = new AppMediator()
        @app.initialize() 




  
module.exports = CXApp  
 