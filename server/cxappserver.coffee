express = require('express')
http = require('http')
path = require('path')
approuter = require('./approuter')
appmiddleware = require('./appmiddleware')
model = require('./models/model')
uuid = require 'node-uuid'
nib = require('nib')
stylus = require('stylus')
jade = require('jade')
url = require('url')




class cxappserver


    data: {}
    debug: true

    server: {}
    app: new express()
    globalPing: ""
    timer: false
    socket: null
    root: __dirname+"/../"
    layout:  null


    cxappserver.allowCrossDomain = (req , res , next) =>
        res.header('Access-Control-Allow-Origin', "*")
        res.header('Access-Control-Allow-Methods', 'GET,OPTIONS,PUT,POST,DELETE')
        res.header('Access-Control-Allow-Headers', 'Content-Type , X-Requested-With')

        next()



    configure: (dataPath, env, next) =>
        
        try
            

            @data = require(dataPath)
            @apps = @data.apps

            if @app.settings.env is 'development'
                @debug = true

                
            else if @app.settings.env  is 'staging'
                @debug = false
              
               
            else if @app.settings.env  is 'production'
                @debug = false
            
            
            if next is undefined                
                @app.set 'port' , process.env.PORT or 1923
                @app.use express.favicon()
                @app.use express.logger('dev')
                @app.use express.bodyParser()
                @app.use express.methodOverride()                
                @app.use cxappserver.allowCrossDomain 
          


            if @app.settings.env isnt 'production'
                @app.configure =>
                    @app.use express.errorHandler
                        dumpExceptions: true
                        showStack: true


            if env isnt undefined and next isnt undefined
                @app.configure(env, next)
            else if next isnt undefined
                next()

            @app.set "view engine" , "jade"
            @enableMultipleViewFolders()            

            views = []
            for a in @apps
                views.push path.normalize @root + a.layout

                if a.views isnt undefined
                    views.push path.normalize @root+a.views

            @app.set "views" , views

            
        catch e
            console.log "Error" , e
        


    create: () =>

        msg = @data.welcome
        if msg is undefined
            msg = "Server Created"
        
        @server = http.createServer(@app)
        
        @middleware()
        @routes()
        @server.listen(@app.get('port') , ( => 
            console.log msg , "[Port]:", @app.get('port') , "[Env]:", @app.settings.env
            ) )

    
  


    middleware: =>  

        for a in @apps
            for p in a.paths
                do (p) =>
                    for css in p.css                    
                        @app.use appmiddleware.css @root+css.src , @root+@data.deploy , @debug
                    for js,i in p.js        
   
                        @app.use appmiddleware.js path.normalize(@root+js.src),  p.public+js.path , path.normalize(@root+data.deploy+p.public+js.path) , @debug
            
        
    routes: =>     

        @app.use express.static(path.join(path.normalize(@root), @data.deploy)) 
        
        @app.use @app.router
        root = @root
        preRender = @preRender
        error = @error
        data = @data
        proccess = process
        for a in @apps            
            do (a) =>
                for p in a.paths              
                    do (p) =>
                        if p.routeRegex isnt undefined
                            route = new RegExp(p.routeRegex)
                        else    
                            route = p.route

                        
                        
                        if p.html isnt undefined
                            @app.get route, (req , res) =>
                                console.log route
                                approuter.index req , res , data.deploy+p.public+p.html

                        else if p.view isnt undefined  
                            
                            @app.get route , (req , res) =>   
                                console.log route
                                result = null
                                if p.data isnt undefined
                                    if p.data.url isnt undefined

                                        if !/^http(s?)/.test(p.data.url)
                                            p.data.url = req.protocol.toString() + "://" + req.headers.host + p.data.url

                                        if p.data.url.indexOf("{route}") isnt -1                                            
                                            params = req.params[0].split("/")
                                            p.data.url = p.data.url.split("{route}").join(params[params.length-1])                                         

                                        options = url.parse(p.data.url)
                                        options.method = "GET"
                            
                                        data = "";
                                        jsonreq = http.get options , (jsonres) =>
                                            

                                            jsonres.on 'data' , (c) =>
                                                data += c.toString()
                                            jsonres.on 'end' , =>

                                                try
                                                    result = JSON.parse(data)
                                                    partialHtml = preRender path.normalize(root + a.views + p.view) , result
                                                    if req.xhr
                                                        if req.get("content-type") is "application/json"
                                                            res.set 
                                                                "content-type" : "application/json"
                                                            res.send result
                                                        else
                                                            res.send partialHtml
                                                    else                            
                                                        res.render a.layout , 
                                                            local: result
                                                            partial: partialHtml
                                                catch e
                                          
                                                    error res , a.layout , preRender( path.normalize(root + a.views + "error")  , {error:e})
                                                   

                                        jsonreq.on 'error' , (e) ->

                                            error res , a.layout , preRender( path.normalize(root + a.views + "error") , {error:e})
                                        
                                        

    getView: (req, res, p) =>

    error: (res, layout, partial, error) ->
   
        res.status(500)
        res.render layout , 
            local: error
            partial: partial


    preRender: (file , data) =>

        file = "#{file}.jade"
        try
            return jade.renderFile(file , data)
        catch e
            error res , a.layout , preRender( path.normalize(root + a.views + "error")  , {error:e})
        

        



            
    enableMultipleViewFolders: ->
  
        # Monkey-patch express to accept multiple paths for looking up views.
        # this path may change depending on your setup.
        View = require("../node_modules/express/lib/view")
        lookup_proxy = View::lookup
        View::lookup = (viewName) ->
            context = undefined
            match = undefined
            if @root instanceof Array
                i = 0
                while i < @root.length
                    context = root: @root[i]
                    match = lookup_proxy.call(context, viewName)
                    return match  if match
                    i++
                return null
            lookup_proxy.call this, viewName






module.exports = cxappserver
