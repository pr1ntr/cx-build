

path = require('path')
through = require('through')





module.exports = htmlr = (filename) ->
    data = ''
    write = (buf) ->
        data += buf
    end = () ->
        safeText = data.replace(/\"/g, '\u005C\u0022')
        safeText = safeText.replace(/^(.*)/gm, '"$1')
        safeText = safeText.replace(/(.+)$/gm, '$1" +')
        safeText = safeText.replace(/\+$/, '')

        finalHtml = 'module.exports = ' + safeText + ';\n';

        @queue finalHtml
        @queue null

    ext = path.extname(filename)
    if ext is ".html"
        return through(write, end)
    else
        return through()

