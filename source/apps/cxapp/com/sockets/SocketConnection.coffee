
CookieManager = require '../model/utils/CookieManager'


class SocketConnection extends Backbone.Model

    socket = ""





    initialize: ->
        socket = io.connect("http://localhost:1923")

        user = CookieManager.getUser()
        socket.emit 'connect' , user



module.exports = SocketConnection