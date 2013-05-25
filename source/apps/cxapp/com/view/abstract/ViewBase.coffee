


class ViewBase extends Backbone.View
    template = ""

    initialize: (temp) ->

        template = temp
        @assets = []
        @moviews = []
        if @options.assets isnt undefined
            @assets = @options.assets

        if @options.movies isnt undefined
            @movies = @options.movies
      


       

    render: (template, m) ->
        model = @model
        if m isnt undefined and m isnt null
            model = m            

        @$el.html _.template( template, {data: model, assets: @assets, movies: @movies}  )


    destroy: () ->
        @$el.html("")
        


    transitionIn: (callback) =>

        
    

        if @$el.length > 0 

            if @$el.css("visibility") is "hidden"
                @render(template)
                TweenMax.set @$el , 
                    autoAlpha:0
                TweenMax.to @$el , .4,
                    autoAlpha:1
                    ease:Cubic.easeOut
                    onComplete: =>
                        if callback isnt undefined
                            callback()
            else
                if callback isnt undefined
                    callback()
        else
            if callback isnt undefined
                callback()

 


    transitionOut: (callback) =>
        
        
        if @$el.length > 0
            if @$el.css("visibility") isnt "hidden"
                TweenMax.set @$el , 
                    autoAlpha:1 
                TweenMax.to @$el , .4,
                    autoAlpha:0
                    ease:Cubic.easeOut
                    onComplete: =>
                        @destroy()
                        if callback isnt undefined
                            callback()
            else
                @destroy()
                if callback isnt undefined
                    callback()
        else
            @destroy()
            if callback isnt undefined
                callback()

                


module.exports = ViewBase