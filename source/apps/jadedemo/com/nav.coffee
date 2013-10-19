

class Nav extends Backbone.View

    initialize: ->

    events: 
        "click .nav-item , .footer-item , .nav-item a , .footer-item a" : "onNavClick"


    onNavClick: (e) =>
        window.preventDefault(e)
        $t = $(e.target).closest("li").find("a")


        console.log $t 
        route = "/"+$t.data('route')

        Backbone.history.navigate route ,
            trigger:true



module.exports = Nav