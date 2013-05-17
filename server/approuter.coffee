buildjs = require('./buildjs')
buildcss = require('./buildcss')
path = require('path')

class approuter

    approuter.index = (req , res, html ) =>
        res.sendfile(path.join(path.normalize(__dirname+"/../"), html));

        


    approuter.js = (req, res, script, src, next) =>

        end = (res) ->
            res.sendfile(path.join(path.normalize(__dirname+"/../") , script))

        buildjs.build src, script, end, res 

    approuter.css = (req, res, script, src ,next) =>
        end = (res) ->
            res.sendfile(path.join(path.normalize(__dirname+"/../") , script))

        buildcss.build src , script, end , res







module.exports = approuter