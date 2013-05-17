class buildcss

    stylus = require('stylus')
    path = require('path')
    fs = require('fs')
    nib = require('nib')

    buildcss.debug = false


    buildcss.build = ( src, dest, callback, res) =>


        try

            file = fs.readFileSync(path.normalize(__dirname+"/../"+src), 'utf8')    
            bp = src.split("/")
            bp.pop()
            basePath = ""
            for str in bp
                basePath += str+"/"
                
            stylus(file)
                .set("paths", [path.normalize(__dirname+"/../"+basePath)])
                .use(nib())
                .render (err, out) =>
                    css = out
                    normDest = path.normalize __dirname+"/../"+dest
                    fs.writeFileSync(normDest, css ,'utf8')
                    callback(res)

        catch e
            console.log e
         



        





module.exports = buildcss