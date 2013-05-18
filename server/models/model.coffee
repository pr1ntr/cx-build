

uuid = require 'node-uuid'

class model


    model.users = {}


    model.getUser = (id) =>      


        
        if model.users[id] isnt undefined
            return model.users[id] 
        else if id isnt undefined
            user = id
            model.users[user] = 
                id:user

            return model.users[user]
        else
            return null

            







                
            
            







module.exports = model