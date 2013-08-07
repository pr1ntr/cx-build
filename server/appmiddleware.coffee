
path = require('path')
stylus = require('stylus')
nib = require('nib')
bundlr = require('bundlr')
jade = require('jade')


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


    appmiddleware.js = (src,route,dest,debug) =>
        
        opts = {}
        opts.src = src
        opts.route = route
        opts.dest = dest
        opts.debug = debug
        opts.write = false
        opts.debug = false

        return bundlr(opts)


    appmiddleware.jade = (src, route, data, debug) =>
    
        
        





module.exports = appmiddleware