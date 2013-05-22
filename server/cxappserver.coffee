express = require('express')
http = require('http')
path = require('path')
approuter = require('./approuter')
appmiddleware = require('./appmiddleware')
sockets = require('./sockets')
model = require('./models/model')
uuid = require 'node-uuid'
io = require 'socket.io'
nib = require('nib')
stylus = require('stylus')



class cxappserver


    data = {}
    debug = true

    server = {}
    app = new express()
    globalPing = ""
    timer = false
    socket = null


    cxappserver.allowCrossDomain = (req , res , next) =>
        res.header('Access-Control-Allow-Origin', "*")
        res.header('Access-Control-Allow-Methods', 'GET,OPTIONS,PUT,POST,DELETE')
        res.header('Access-Control-Allow-Headers', 'Content-Type')

        next()



    configure: (dataPath, env, next) =>
        
        try
            

            data = require(dataPath)
            @apps = data.apps

            
        

            if app.settings.env is 'development'
                debug = true

                
            else if app.settings.env  is 'staging'
                debug = false
              
               
            else if app.settings.env  is 'production'
                debug = false
            
            
            if next is undefined                
                app.set 'port' , process.env.PORT or 1923
                app.use express.favicon()
                app.use express.logger('dev')
                app.use express.bodyParser()
                app.use express.methodOverride()                
                app.use cxappserver.allowCrossDomain 


            if app.settings.env isnt 'production'
                app.configure =>
                    app.use express.errorHandler
                        dumpExceptions: true
                        showStack: true


            if env isnt undefined and next isnt undefined
                app.configure(env, next)
            else if next isnt undefined
                next()




   
            
        catch e
            console.log "Error" , e
        


    create: () =>

        msg = data.welcome
        if msg is undefined
            msg = "Server Created"
        
        server = http.createServer(app)
        
        @middleware()
        @routes()

        @sockets()
        globalPing = setInterval (=>
            @onGlobalPing(socket)
            )  , 5000
        @onGlobalPing(socket)


        server.listen(app.get('port') , ( => 
            console.log msg , "[Port]:", app.get('port') , "[Env]:", app.settings.env
            ) )

    
    sockets: =>

        
        
        io = io.listen server
        user = {}

        io.sockets.on 'connection' , (s) => 

            socket = s
            socket.on 'connect' , (data) =>
                user = model.getUser(data)
                console.log 'user:' , user
                socket.set user.id , user , =>
                    socket.emit 'success' ,  user

            socket.on 'geo' , (data) =>
                model.users[data.id] = data
                user = data
                console.log "USER" , user

    onGlobalPing: (socket)=>
        if socket isnt undefined and socket isnt null
            socket.emit 'global_ping' , model.users

    middleware: =>   


        for a in @apps

            for p in a.paths

                for css in p.css                    
                    app.use appmiddleware.css __dirname+"/../"+css.src , __dirname+"/../"+data.deploy , debug

                for js in p.js   
                    app.use appmiddleware.js __dirname+"/../"+js.path+js.src ,  __dirname+"/../"+js.path, __dirname+"/../"+data.deploy+p.public+js.script, debug
  

        app.use express.static(path.join(path.normalize(__dirname+"/../"), data.deploy)) 
               
        
        
    routes: =>     
        app.use app.router
        for a in @apps

            for p in a.paths

                app.get p.route , (req , res) =>
                    approuter.index req , res , data.deploy+p.public+p.html

            






        









module.exports = cxappserver
