

path = require('path')
coffeeify = require('coffeeify')
browserify = require('browserify')
brfs = require('brfs')
uglify = require('uglify-js')
mime = require('mime')
through = require('through')
fs = require('fs')
htmlr = require('browserify-htmlr')


module.exports = bundlr = (opts) ->
    
    src = opts.src
    route = opts.route
    dest = opts.dest
    debug = opts.debug
    write = opts.write or true
    caching = opts.cache or false
    watchCallback = opts.watchCallback or (err, data) ->
        if err
            console.log err
        else 
            console.log "bundle success."

    console.log "[Source]:" , src
    console.log "[Route]:" , route
    console.log "[Dest]:" , dest

    
    b = browserify() 
    
    b.transform(coffeeify)  
    b.transform(brfs)   
    b.transform(htmlr)

    b.transform (filename) ->
        b.allFiles.push(filename)
        return through()

       


    b.add src
    


    
    
   
    cache = {}

         

 
    

    return (req, res, next) ->



        watchFiles = (b, path) ->
            watchers = b.allFiles.map (filename) ->
                fs.watch filename , {persist:false} , () ->
                    delete cache[path]
                    generate b , watchCallback

                    watchers.forEach (watcher) ->
                        watcher.close()



        sendResponse = (err, src) ->
            if err
                next(err)
            else
                

                res.contentType('application/javascript')
                res.send(src)
        generate = (b , callback) ->
            
            try
                b.allFiles = []
                b.bundle {debug:debug} , (err, src) ->
                    compress = !debug
                    watch = debug
                    if watch
                        watchFiles(b, req_path)

                    

                    if err
                        return callback(err)


                    if compress
                        result = uglify.minify src ,
                            fromString:true

                        src = result.code

                    cache[req_path] = src

                    
                    


                    if write
                        fs.writeFile dest , src, 'utf8', ->
                            console.log "File Written."

                    callback(null,src)

            catch err

                return callback(err)
            
            

            


        req_path = req.path



        if !path.extname(req_path)
            return next()
        else if mime.lookup(req_path) isnt "application/javascript"
            return next()


        if req_path is route   
            if caching and cache[req_path] isnt undefined
                sendResponse(null, cache[req_path])
            else
                generate(b , sendResponse)
        else
            next()