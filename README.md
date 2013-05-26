cx-build
========

Allows creation of javascript applications with a json descriptor. 

To create new project use a couple of handy cake commands.


cake help
  
displays cake help

    example: cake help


cake scaffold  
    
creates folders and bootstrap files and json descriptor for template application
    
arguments:
  
    -d --destination [destination] destination directory. default: none
    -n --name [name] name for app template. default: cx
    -m --multi [multi] if application should run from a folder named by --name. default: false
    -j --javascript [javascript] will create project with a javascript bootstrap. default: false
 
    example:   cake -n my-new-app -m false -j true scaffold


cake run

runs the server with in development or production mode. pass in the descriptor json for it to run.
    
arguments:
  
    -e --env [environment] sets server environment mode .
    -D --data [data] sets path to app descriptor json.

    example:   cake -e development -D ../<name of app>.json run
