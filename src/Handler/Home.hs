module Handler.Home where

import Init

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "SomeBlog"
    
    -- change src URIs in production
    addStylesheetRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/css/normalize.css"
    addStylesheetRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/css/bs-3.0/bootstrap.min.css"
    addStylesheetRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/css/style.css"
    addScriptRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/js/libs/jquery-1.9.1.js"
    addScriptRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/js/libs/handlebars-1.0.0.js"
    addScriptRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/js/libs/ember-1.0.0.js"
    addScriptRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/js/App.js"
    addScriptRemote "//rawgithub.com/mkrull/yesod-ember-skel/master/static/js/libs/bs-3.0/bootstrap.min.js"
    $(widgetFile "home")
