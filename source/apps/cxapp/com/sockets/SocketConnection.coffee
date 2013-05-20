
CookieManager = require '../model/utils/CookieManager'



class SocketConnection extends Backbone.Model

    socket = ""

    user = ""



    start: ->

 
        console.log "connect."
        socket = io.connect "http://192.168.1.160:1923" 

        @user = CookieManager.getUser()
        
        socket.on 'success' , @onConnectSuccess
        
        socket.on 'global_ping' , @onGlobalPing

        socket.emit 'connect' , @user 



            
    onConnectSuccess: (data) =>
        console.log "connect success."
        user = data

        @trigger("connect" , user)

    onGlobalPing: (data) =>
        @trigger("globalPing" , data)


    
    broadcast: (data) =>
        #console.log 'ping.'
        user.geo = JSON.parse(data)
        socket.emit 'geo' , user




module.exports = SocketConnection