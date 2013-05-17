class BuildCSS

    stylus = require('stylus')
    path = require('path')
    fs = require('fs')
    nib = require('nib')

    srcPath = ""
    src = ""
    dest = ""

    constructor: (srcPath, src, dest) ->
        @srcPath = srcPath
        @src = src
        @dest = dest


    build: ( callback, res) =>


        try

            file = fs.readFileSync(__dirname+@srcPath+@src, 'utf8')    

            stylus(file)
                .set("paths", [path.normalize(path.resolve() + "/" + @srcPath)])
                .use(nib())
                .render (err, out) =>
                    css = out
                    normDest = path.normalize __dirname+@dest
                    fs.writeFileSync(normDest, css ,'utf8')
                    callback(res)

        catch e
            console.log e
         

    _onSyntaxError: (e) ->
        console.log('Compile Error', e)

    _onBundle: (e) ->         
        console.log('Bundle ', arguments)


        





module.exports = BuildCSS