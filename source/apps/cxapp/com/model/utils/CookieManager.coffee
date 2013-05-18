uuid = require 'node-uuid'

class CookieManager
    
   
    CookieManager.getUser = =>
        user = @getCookie("e_game_user_guid")
        if user is undefined or user is null or user is ""
            @setCookie("e_game_user_guid" , @guid(), 360)
            user = @getCookie("e_game_user_guid")
        else
            @setCookie("e_game_user_guid" , user, 360)
            user

   
    

   
    CookieManager.getCookie = (c_name) ->
        
        return localStorage.getItem(c_name)
        
            
        
    CookieManager.setCookie = (c_name, value, exdays) ->

        exdate = new Date()
        exdate.setDate(exdate.getDate() + exdays)
        c_value = escape(value) + if (exdays == null) then "; path=/" else "; expires=" + exdate.toUTCString() + "; path=/" 

        if value is null
            localStorage.removeItem(c_name)
        else
            localStorage.setItem(c_name, value)


    CookieManager.guid = ->
        return uuid.v4()


module.exports = CookieManager