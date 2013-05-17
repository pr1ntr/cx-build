
AppModel = require '../model/AppModel'
Header = require './Header'
Breadcrumbs = require './Breadcrumbs'
Navigation = require './Navigation'
Intro = require './Intro'
SelectMovie = require './SelectMovie'
SelectPhoto = require './SelectPhoto'
InsertCaption = require './InsertCaption'
PreloaderZed = require '../model/utils/PreloaderZed'



class AppMediator
    
    model = {}



    steps = []
    currentStep = 0
    currentView = null



    constructor: () ->

        model = AppModel.getInstance()
        console.log model
        
        
        @header = new Header
            el:"#header"
            model: model.get("app")
            assets: PreloaderZed.loadedImages
        @header.render()

        @breadcrumbs = new Breadcrumbs
            el:"#breadcrumbs"
            model: model.get("app").get('global')
            assets: PreloaderZed.loadedImages
        @breadcrumbs.render()


        @navigation = new Navigation
            el:"#navigation"
            model: model.get("app").get('global')
            assets: PreloaderZed.loadedImages
        @navigation.render()
        



        @intro = new Intro
            el:"#content"
            model:model.get("app").get("intro")
            assets:PreloaderZed.loadedImages


        @selectMovie = new SelectMovie
            el:"#content"
            model: model.get('app').get("selectMovie")
            assets:PreloaderZed.loadedImages
            movies: model.get('app').get('global').movies

        @selectPhoto = new SelectPhoto
            el:"#content"
            model:model.get('app').get("selectPhoto")
            assets:PreloaderZed.loadedImages
            movies:model.get('app').get('global').movies

        @insertCaption = new InsertCaption
            el:"#content"
            model:model.get('app').get("insertCaption")
            assets:PreloaderZed.loadedImages
            movies:model.get('app').get('global').movies


        

        model.on 'change:step' , @onStepChange

        steps = [@intro, @selectMovie, @selectPhoto, @insertCaption]

        



        
      

    initialize: () =>


       
        currentView = @intro
        model.set 'step' , 0
        model.set 'movie' , null
        model.set 'image' , null


    onStepChange: () =>
        
        


        i = model.get('step')

        step = steps[i]
        console.log currentView
        if currentView isnt step
            currentView.transitionOut step.transitionIn
            currentView = step
        else
            step.transitionIn()


        if i isnt 0
            @navigation.transitionIn()
            @breadcrumbs.transitionIn()
        else
            @navigation.transitionOut()
            @breadcrumbs.transitionOut()












module.exports = AppMediator

