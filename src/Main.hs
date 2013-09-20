module Main where

import Yesod

-- widgetFile must be imported
import Import

import Data.Text (Text)
import Database.Persist.Quasi (lowerCaseSettings)
import Database.Persist.Sqlite
    ( ConnectionPool, SqlPersistT, runSqlPool, runMigration
    , createSqlitePool, runSqlPersistMPool
    )
import Data.Time (UTCTime, getCurrentTime)
import Network.HTTP.Conduit (Manager, newManager, def)

share [mkPersist sqlOnlySettings, mkMigrate "migrateAll"] $(persistFileWith lowerCaseSettings "config/models")

data Ember = Ember
   { connPool    :: ConnectionPool
   , httpManager :: Manager
   }

instance Yesod Ember

instance YesodPersist Ember where
   type YesodPersistBackend Ember = SqlPersistT
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool
       
mkYesod "Ember" $(parseRoutesFile "config/routes")

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Uninets"
    
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
    
main :: IO ()
main = do
    pool <- createSqlitePool "database.sqlite" 10 -- create a new pool
    -- perform any necessary migration
    runSqlPersistMPool (runMigration migrateAll) pool
    manager <- newManager def -- create a new HTTP manager
    warpEnv $ Ember pool manager -- start our server
    