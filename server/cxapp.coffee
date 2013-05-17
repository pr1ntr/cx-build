express = require('express')
http = require('http')
path = require('path')
coffee = require('coffee-script')
uglify = require('uglify-js')
buildjs = require('./buildjs');
buildcss = require('./buildcss');



class CXAppServer extends express


    debug = false


    CXAppServer.allowCrossDomain = (req , res , next) =>
        res.header('Access-Control-Allow-Origin', "*")
        res.header('Access-Control-Allow-Methods', 'GET,OPTIONS,PUT,POST,DELETE')
        res.header('Access-Control-Allow-Headers', 'Content-Type')

        next()


    configure: (env, next) ->

        @set 'port' , process.env.PORT || 105
        @use express.favicon()
        @use express.logger('dev')
        @use express.bodyParser()
        @use express.methodOverride()
        @use app.router
        @use CXAppServer.allowCrossDomain 

        if env is 'development'
            debug = true

        if env is 'staging'
            debug = false

        if env isnt 'production'
            @use express.errorHandler
                dumpExceptions: true
                showStack: true


        super(env, next)


    constructor: () ->
        @use express.static path.join __dirname, '/public/#appname'



        









module.exports = CXAppServer
