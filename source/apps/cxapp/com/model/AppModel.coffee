
PreloaderZed = require './utils/PreloaderZed'
ModelBase = require './abstract/ModelBase'


class AppModel extends ModelBase
    
    
    allowInstantiation = false
    instance = null
    started = false

    assetManifest = []
    opts = {}


    preloader = new PreloaderZed()
 
    constructor: (opts) ->
        if !allowInstantiation
            throw 'AppModel is a singleton. Use AppModel.getInstance() instead.'
        else
            allowInstantiation = false
            opts = opts
            super(opts)

    AppModel.getInstance = (opts) ->
        if instance is null
            allowInstantiation = true
            instance = new AppModel(opts) 
        instance

      
    initialize: (opts) => 
        @opts = opts
        @url = opts.url
        super()
        @on 'change' , @onAppModelData

    onAppModelData: (target) =>
        @off 'change' , @onAppModelReady
        
        @createLoadManifest()
        @scaffoldData(@attributes)
        @searchAssets(@get("app").attributes)
        @trigger 'dataReady' , @


    processMovies: =>

    searchAssets: (object) =>
        
        for item of object
            if item is "assets"
                for asset of object[item]
                    a =
                        id: asset
                        src: object[item][asset]
                    PreloaderZed.loadedImages[a.id] = a
            else if typeof object[item] is "object"
                @searchAssets(object[item])


    createLoadManifest: () =>
        

        app = @get 'app'
        @searchAssets(app)
        if PreloaderZed.hasManifest()
            @initPreload()
        else
            @onAssetsComplete()



        


       
    initPreload: () =>
        preloader.onProgress = @onAssetsProgress
        preloader.onComplete = @onAssetsComplete
        preloader.load()

        

    onAssetsProgress: (e) =>
        loaded =  e
        @trigger 'progress' , loaded
             
    onAssetsComplete: (e) =>
        started = true

        @trigger 'ready', @



       

module.exports = AppModel   
