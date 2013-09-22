module Handler.Home where

import Init

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "SomeBlog"
    
    -- change src URIs in production
    addStylesheetRemote "http://static.uninets.eu/blogha/static/css/normalize.css"
    addStylesheetRemote "http://static.uninets.eu/blogha/static/css/bs-3.0/bootstrap.min.css"
    addStylesheetRemote "http://static.uninets.eu/blogha/static/css/style.css"
    addScriptRemote "http://static.uninets.eu/blogha/static/js/libs/jquery-1.9.1.js"
    addScriptRemote "http://static.uninets.eu/blogha/static/js/libs/handlebars-1.0.0.js"
    addScriptRemote "http://static.uninets.eu/blogha/static/js/libs/ember-1.0.0.js"
    addScriptRemote "http://static.uninets.eu/blogha/static/js/App.js"
    addScriptRemote "http://static.uninets.eu/blogha/static/js/libs/bs-3.0/bootstrap.min.js"
    $(widgetFile "home")
