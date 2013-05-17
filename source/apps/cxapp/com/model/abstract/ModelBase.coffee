

class ModelBase extends Backbone.Model
    
    initialize: (opts) ->
        super(opts)





    scaffoldData: (ctx) =>
        for key of ctx
            obj = ctx[key]
            if $.isArray(obj) is true
                @set key , new Backbone.Collection obj
            else if typeof obj is "string" or typeof obj is "number" or typeof obj is "boolean" or obj is null
                @set key , obj
            else if typeof obj is "object" 
                @set key , new Backbone.Model obj



       

    

module.exports = ModelBase