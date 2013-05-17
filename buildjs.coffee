class BuildJS

    browserify = require('browserify')
    path = require('path')
    fs = require('fs')
    stringify = require('stringify')

    srcPath = ""
    src = ""
    dest = ""
  


    constructor: (srcPath, src, dest) ->
        @srcPath = srcPath
        @src = src
        @dest = dest


    build: (debug, callback, res) =>


        try
          

            opts = {}
            opts.debug = if debug isnt undefined then debug else false
            opts.cache = false
            opts.watch = if debug isnt undefined then debug else false
            if !opts.debug then opts.filter = require('uglify-js')

            b = browserify(opts)
            b.use stringify('.html')
            b.addEntry path.normalize __dirname+@srcPath+@src 
            b.on 'syntaxError' , @_onSyntaxError  
            b.on 'bundle' , @_onBundle  
            
            data = b.bundle()
            
            normDest = path.normalize __dirname+@dest
            
            fs.writeFileSync(normDest, data ,'utf8')
            callback(res)
            
            

            


        catch e
            console.log 'error' , e

    _onSyntaxError: (e) =>
        console.log('Compile Error', e)

    _onBundle: (e) =>         
        console.log('Bundle ', arguments)



        





module.exports = BuildJS