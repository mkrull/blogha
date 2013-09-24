module Init ( module Init, module X ) where

import           Language.Haskell.TH     (ExpQ)
import           Yesod                   as X
import           Yesod.Default.Config
import           Yesod.Default.Util      as X (widgetFileReload)

import           Data.Text               as X (Text)
import           Data.Time               as X (UTCTime, getCurrentTime)

import           Data.Aeson              as X (encode, object, toJSON, (.=))
import           Database.Persist.Quasi  (lowerCaseSettings)
import           Database.Persist.Sqlite as X (ConnectionPool, SqlPersistT,
                                               createSqlitePool, runMigration,
                                               runSqlPersistMPool, runSqlPool)
import           Network.HTTP.Conduit    as X (Manager, def, newManager)
import           System.IO               as X (stdout)
import           System.Log.FastLogger   as X (Logger, mkLogger)

-- create database related
share [mkPersist sqlOnlySettings, mkMigrate "migrateAll"] $(persistFileWith lowerCaseSettings "config/models")

widgetFile :: FilePath -> ExpQ
widgetFile = widgetFileReload def

data Ember = Ember
   { connPool    :: ConnectionPool
   , httpManager :: Manager
   , emberLogger :: Logger
   }

-- init persist instance
instance YesodPersist Ember where
   type YesodPersistBackend Ember = SqlPersistT
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool

instance Yesod Ember where
    makeLogger = return . emberLogger

mkYesodData "Ember" $(parseRoutesFile "config/routes")

