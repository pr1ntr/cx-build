express = require('express')
http = require('http')
path = require('path')
coffee = require('coffee-script')
uglify = require('uglify-js')
buildjs = require('./buildjs')
buildcss = require('./buildcss')
approuter = require('./approuter')


class cxappserver


    data = {}
    debug = true


    server = new express()

    cxappserver.allowCrossDomain = (req , res , next) =>
        res.header('Access-Control-Allow-Origin', "*")
        res.header('Access-Control-Allow-Methods', 'GET,OPTIONS,PUT,POST,DELETE')
        res.header('Access-Control-Allow-Headers', 'Content-Type')

        next()



    configure: (dataPath, env, next) =>
        
        try
            

            data = require(dataPath)
            @apps = data.apps

            
        

            if server.settings.env is 'development'
                debug = true
                
            else if server.settings.env  is 'staging'
                debug = false
              
               
            else if server.settings.env  is 'production'
                debug = false
            

            
            
            if next is undefined
                server.configure =>
                    server.set 'port' , process.env.PORT or 1923
                    server.use express.favicon()
                    server.use express.logger('dev')
                    server.use express.bodyParser()
                    server.use express.methodOverride()
                    server.use server.router
                    server.use cxappserver.allowCrossDomain 


            if server.settings.env isnt 'production'
                server.configure =>
                    server.use express.errorHandler
                        dumpExceptions: true
                        showStack: true

            if env isnt undefined and next isnt undefined
                server.configure(env, next)


            buildjs.debug = debug
            @routes()
        catch e
            console.log "Error" , e
        


        
    routes: =>     
        
 

        for app in @apps

            for p in app.paths
        
                server.get p.route, (req , res) =>
                    approuter.index req , res , data.deploy+p.public+p.html

                for js in p.js
              
                    server.get p.route+js.script , (req, res) =>
                        approuter.js req , res, data.deploy+p.public+js.script, p.source+js.src



                for css in p.css
                    server.get p.route+css.script , (req, res) =>
                        approuter.css req , res, data.deploy+p.public+css.script, p.source+css.src

        server.use(express.static(path.join(path.normalize(__dirname+"/../"), data.deploy)))

            






        
        






    create: () =>
        msg = data.welcome
        if msg is undefined
            msg = "Server Created"
        http.createServer(server).listen(server.get('port') , (=> 
            console.log msg , "[Port]:", server.get('port') , "[Env]:", server.settings.env
            ) )


        









module.exports = cxappserver
