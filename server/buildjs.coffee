class buildjs

    browserify = require('browserify')
    path = require('path')
    fs = require('fs')
    stringify = require('stringify')

    
  
    buildjs.debug = false






    buildjs.build = (src , dest, callback, res) =>


        try
            
            opts = {}
            opts.debug = buildjs.debug
            opts.cache = false
            opts.watch = buildjs.debug
            if !opts.debug then opts.filter = require('uglify-js')

            b = browserify(opts)
            b.use stringify('.html')
            b.addEntry path.normalize __dirname+"/../"+src 
            b.on 'syntaxError' , buildjs.onsyntaxerror
            b.on 'bundle' , buildjs.onbundle 
            
            data = b.bundle()

            
            normDest = path.normalize __dirname+"/../"+dest

           
            
            fs.writeFileSync(normDest, data ,'utf8')
            
            callback(res)
            
            

            


        catch e
            console.log 'error' , e

    buildjs.onsyntaxerror = (e) =>
        console.log('[Compile Error]:', e)

    buildjs.onbundle = (e) =>         
        #console.log('Bundle ', arguments)



        





module.exports = buildjs