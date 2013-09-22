module Init ( module Init, module X ) where

import Yesod as X
import Yesod.Default.Config
import Yesod.Default.Util as X
import Language.Haskell.TH (ExpQ)

import Database.Persist.Quasi (lowerCaseSettings)
import Database.Persist.Sqlite as X
    ( ConnectionPool, SqlPersistT, runSqlPool, runMigration
    , createSqlitePool, runSqlPersistMPool
    )
import Network.HTTP.Conduit as X (Manager, newManager, def)

-- create database related
share [mkPersist sqlOnlySettings, mkMigrate "migrateAll"] $(persistFileWith lowerCaseSettings "config/models")

widgetFile :: FilePath -> ExpQ
widgetFile = widgetFileReload def

data Ember = Ember
   { connPool    :: ConnectionPool
   , httpManager :: Manager
   }

-- init persist instance
instance YesodPersist Ember where
   type YesodPersistBackend Ember = SqlPersistT
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool

instance Yesod Ember
mkYesodData "Ember" $(parseRoutesFile "config/routes")
