
path = require('path')
stylus = require('stylus')
nib = require('nib')
browserify_express = require('browserify-express')

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
        bundle = browserify_express
            entry:src
            watch:watch
            mount:dest
            verbose: debug
            minify: !debug
            bundle_opts: {debug:debug}
            watch_upts: {recursive: false}



    







module.exports = appmiddleware