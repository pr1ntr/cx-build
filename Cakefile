fs = require 'fs'
path = require 'path'
sys = require 'sys'
{spawn, exec} = require 'child_process'
ncp = require('ncp').ncp
ncp.limit = 8
defaults =
    root:""
    name :"cx"
    multi:false
    javascript:false
    data:"app.json"



assets = 
    directory:"/cxassets/"
    main: "main.coffee"
    style:"main.styl"
    index:"index.html"
    modernizr: "modernizr-2.6.2-respond-1.1.0.min.js"
    greensock: "greensock"
    createjs: "create"

template =
    source: [
        "/source"
        ,"/source/apps/"
        ,"/source/apps/{name}/"
        ,"/source/apps/{name}/com"
        ,"/source/apps/{name}/styles"
        ,"/source/apps/{name}/include"
        ,"/source/apps/{name}/templates"
        ]
    public: [
        "/public"
        ,"/public/{pub}"
        ,"/public/{pub}data"
        ,"/public/{pub}images"
        ,"/public/{pub}js"
        ,"/public/{pub}js/vendor"
        ,"/public/{pub}styles"
    ]



option "-d" , "--destination [destination]" , 'destination directory. default: none'
option "-n" , "--name [name]" , 'name for app template. default: cx'
option "-m" , "--multi"  , 'if application should run from a folder named by --name. default: false'
option "-j" , "--javascript" , 'will create project with a javascript bootstrap. default: false'

option "-e" , "--env [environment]" , 'sets server environment mode'
option "-D" , "--data [data]" , 'sets path to app descriptor json'


task 'test' , '' , (options) ->
    console.log arguments


task 'help' , 'show help' , (options) ->
    
    console.log ""
    console.log "cmd:  scaffold\narguments:"
    console.log "-d" , "--destination [destination]" , 'destination directory. default: none'
    console.log "-n" , "--name [name]" , 'name for app template. default: cx'
    console.log "-m" , "--multi [multi]" , 'if application should run from a folder named by --name. default: false'
    console.log "-j" , "--javascript [javascript]" , 'will create project with a javascript bootstrap. default: false'
    console.log "\nexample:   cake -n my-new-app -m -j \n" 


    console.log "cmd:  run\narguments:"
    console.log "-e" , "--env [environment]" , 'sets server environment mode .'
    console.log "-D" , "--data [data]" , 'sets path to app descriptor json. '
    console.log "\nexample:   cake -e development -D ../cx2.json"
    console.log "\n"




task 'scaffold' , 'Scaffold a new blank project' , (options) ->

    

    root = options.destination or defaults.root
    appname = options.name or defaults.name
    multi = options.multi or defaults.multi
    js = options.javascript or defaults.javascript

    console.log multi
    pub = ""
    if multi is 'true' 
        console.log "?"
        pub = appname + "/"

    data = require path.normalize(__dirname+assets.directory+defaults.data)
    app = data.apps[0]
    
   
    if js then assets.main = assets.main.split("coffee").join("js")
    scriptDest = assets.main.split("coffee").join("js")

    for p in app.paths
        #console.log p.js



        for js in p.js            
            js.path = "#{pub}js/#{scriptDest}"
            js.src = "/source/apps/#{appname}/#{assets.main}"

        for css in p.css
            css.src = "/source/apps/#{appname}"

        app.name = appname
        p.route = "/#{pub}*"
        p.public = "/#{pub}"
        p.html = "/#{assets.index}"

    data.apps[0] = app

    dest = path.normalize __dirname+root+"/#{appname}.json"
    fs.writeFileSync(dest, JSON.stringify(data, null, 4), 'utf8' )
    
    

        
    for src in template.source
        src = root + src.split("{name}").join(appname)
        src = path.normalize __dirname+src
        if !fs.existsSync src then fs.mkdirSync src

    for src in template.public
        src = root + src.split("{pub}").join(pub)
        src = path.normalize __dirname+src
        if !fs.existsSync src then fs.mkdirSync src
        
        
    dir = assets.directory

    src = []
    dest = []
    src[0] = path.normalize __dirname+dir+assets.main
    dest[0] = path.normalize __dirname+root+ "/source/apps/#{appname}/#{assets.main}" 

    fs.readFile src[0] , (err,data) ->
        if err
            throw err
        str = data.toString().split("{dir}").join(appname)

        fs.writeFileSync(dest[0], str)

    src[1] = path.normalize __dirname+dir+assets.index
    dest[1] = path.normalize __dirname+root+ "/public/#{pub}/#{assets.index}" 

    fs.readFile src[1] , (err,data) ->
        if err
            throw err
        str = data.toString().split("{dir}").join(pub)

        fs.writeFileSync(dest[1], str)

    src[2] = path.normalize __dirname+dir+assets.greensock
    dest[2] = path.normalize __dirname+root+ "/source/apps/#{appname}/include/#{assets.greensock}" 
    ncp  src[2], dest[2] , (err) ->
        if err
            console.log err



    src[3] = path.normalize __dirname+dir+assets.createjs
    dest[3] = path.normalize __dirname+root+ "/source/apps/#{appname}/include/#{assets.createjs}" 
    ncp  src[3], dest[3] , (err) ->
        if err
            console.log err



    src[4] = path.normalize __dirname+dir+assets.style
    dest[4] = path.normalize __dirname+root+ "/source/apps/#{appname}/styles/#{assets.style}" 
    ncp  src[4], dest[4] , (err) ->
        if err
            console.log err

    src[5] = path.normalize __dirname+dir+assets.modernizr
    dest[5] = path.normalize __dirname+root+ "/public/#{pub}js/vendor/#{assets.modernizr}" 
    ncp  src[5], dest[5] , (err) ->
        if err
            console.log err




task 'run' , 'start server in whatever mode' , (options) ->
    if options.env is undefined
        throw new Error "set --env [-e] switch"

    if options.data is undefined
        throw new Error "set --data [-D] switch"

    terminal = spawn 'bash'

   
    terminal.stdout.on 'data' , (data) -> sys.print data
    terminal.stdout.on 'exit' , (data) -> console.log data , "server exit."


    terminal.stdin.write "NODE_ENV=#{options.env} APP_DATA=#{options.data} node server.js"
    terminal.stdin.end()








     