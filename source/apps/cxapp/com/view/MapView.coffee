

ViewBase = require './abstract/ViewBase'

class MapView extends ViewBase
    

    map = {}
    self = {}
    markers = []
    initialize: ->
        

        @model.on "globalPing" , @updateMapMarkers
        @model.on "change:geo" , @updateUserLocation
        @model.on "connectUser" , @onUserConnect
        @updateGeolocation()


    updateGeolocation: () =>

        navigator.geolocation.getCurrentPosition (data) =>
     
            geo = data
            mapOptions =
                center: new google.maps.LatLng(geo.latitude , geo.longitude)
                zoom:15
                mapTypeId: google.maps.MapTypeId.ROADMAP

            map = new google.maps.Map(@$el[0] , mapOptions)
  

    onUserConnect: =>
        user = @model.get('user')
        navigator.geolocation.getCurrentPosition (data) =>
            @createMarker(data, user.id, true)
          

    createMarker: (geo, id, self) =>

        if self
            color = "green.png"
        else
            color = "blue.png"

        image = new google.maps.MarkerImage("/cxapp/images/#{color}" 
            ,new google.maps.Size(35,35)
            ,new google.maps.Point(0,0)
            ,new google.maps.Point(17.5, 25)) 

        marker = new google.maps.Marker
            position:new google.maps.LatLng(geo.latitude , geo.longitude)
            map:map
            icon:image

        markers[id] = marker
    updateMaker: (geo, id) =>

    


    updateMapMarkers: (geo, id) =>







module.exports = MapView