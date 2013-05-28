cx-build
========

Allows creation of javascript applications with a json descriptor. 
----------
---

To create new project use a couple of handy cake commands.

---
cake help  
displays help

    cake help


cake scaffold      
creates folders and bootstrap files and json descriptor for template application
  
  -d --destination [destination] destination directory. default: none
  -n --name [name] name for app template. default: cx
  -m --multi  if application should run from a folder named by --name. default: false
  -j --javascript  will create project with a javascript bootstrap. default: false
 
    cake -n my-new-app -m -j scaffold


cake run
runs the server with in development or production mode. pass in the descriptor json for it to run.
  
  -e --env [environment] sets server environment mode .
  -D --data [data] sets path to app descriptor json.

    cake -e development -D ../<name of app>.json run

--
--
