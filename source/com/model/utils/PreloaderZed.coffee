class PreloaderZed

   

    imagesTotal = 0
    imagesLoaded = 0
    @onProgress 
    @onComplete


    PreloaderZed.loadedImages = {}

    PreloaderZed.hasManifest = =>
      

        return if PreloaderZed.count() > 0 then true else false

    PreloaderZed.count = =>
        i = 0
        for item of PreloaderZed.loadedImages
            i++


        return i

    constructor: ->


    load: () =>

        imagesTotal = PreloaderZed.count()

        for i of PreloaderZed.loadedImages           

            item = PreloaderZed.loadedImages[i]

            image = new Image()
            image.onload = @onInternalProgress
            image.src = item.src
            item.image = image
            

    onInternalProgress: (e) =>
        imagesLoaded++
        @onProgress imagesLoaded/imagesTotal

        if imagesLoaded/imagesTotal is 1
            @onComplete imagesLoaded/imagesTotal




    



module.exports = PreloaderZed