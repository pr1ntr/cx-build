


class Router extends Backbone.Router
    

    

    initialize: ->
        console.log "Router Init"

        @route "*path" , @gotoSection
       

        Backbone.history.start
            pushState:true
            root: window.ROOT or "/"





    gotoSection: (path) =>
        currentId = $(".current").find(">:first-child").attr("id")
        console.log path
        if currentId isnt path
            console.log "go to new path"
            @loadNextSection path
           

    loadNextSection: (path) =>
        html = ""
        $.ajax 
            async:false
            url: "/"+path
            complete: @renderNextSection
          


    renderNextSection: (data) =>

        try
            html = $(data.responseText)
        catch e
            throw e

        next = $(".next")
        current = $(".current")
        next.append(html).addClass("current").removeClass("next")
        current.empty().addClass("next").removeClass("current")
       





       

        

module.exports = Router