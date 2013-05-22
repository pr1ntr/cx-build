
path = require('path')
stylus = require('stylus')
nib = require('nib')
stringify = require('stringify')
browserify = require('browserify')


class appmiddleware



    appmiddleware.css = (src,dest,debug) =>
        stylus.middleware
            src: src
            dest: dest
            compile : (str, path) ->

                stylus(str)
                    .set('filename' , path)
                    .set( 'compress' , !debug)
                    .use(nib())


    appmiddleware.js = (src,watch,dest,debug) =>
        
        opts = {}
        opts.debug = debug
        opts.cache = !debug
        opts.watch = debug
        if debug then opts.filter = require('uglify-js')
        b = browserify(opts)
        b.use(stringify('.html'))
        b.addEntry(path.normalize(src))

        data = b.bundle()



        return (req , res,next) ->
            if req.url.split('?')[0] is opts.mount
                res.statusCode = 200
                res.setHeader('last-modified', cache_time.toString())
                res.setHeader('content-type', 'text/javascript')
                res.end(data)
            
            else 
                next()
            



    







module.exports = appmiddleware