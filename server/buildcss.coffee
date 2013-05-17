class buildcss

    stylus = require('stylus')
    path = require('path')
    fs = require('fs')
    nib = require('nib')

    buildcss.debug = false


    buildcss.build = ( src, dest, callback, res) =>


        try

            file = fs.readFileSync(path.normalize(__dirname+"/../"+src), 'utf8')    
            basePath = src.match(/\/\w+\//)
            console.log basePath[0]
            stylus(file)
                .set("paths", [path.normalize(__dirname+"/../"+basePath[0])])
                .use(nib())
                .render (err, out) =>
                    css = out
                    normDest = path.normalize __dirname+"/../"+dest
                    fs.writeFileSync(normDest, css ,'utf8')
                    callback(res)

        catch e
            console.log e
         



        





module.exports = buildcss