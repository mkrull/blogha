module Main where

-- initialized
import Init

-- Handlers
import Handler.Home

mkYesodDispatch "Ember" resourcesEmber

main :: IO ()
main = do
    pool <- createSqlitePool "database.sqlite" 10 -- create a new pool
    -- perform any necessary migration
    runSqlPersistMPool (runMigration migrateAll) pool
    manager <- newManager def -- create a new HTTP manager
    warpEnv $ Ember pool manager -- start our server
    