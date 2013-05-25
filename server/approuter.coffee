
path = require('path')

class approuter

    approuter.index = (req , res, html ) =>
        res.sendfile(path.join(path.normalize(__dirname+"/../"), html));

        







module.exports = approuter