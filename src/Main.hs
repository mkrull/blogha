module Main where

-- initialized
import           Init

-- Handlers
import           Handler.Fixtures
import           Handler.Home
import           Handler.Posts

mkYesodDispatch "Ember" resourcesEmber

main :: IO ()
main = do
    pool <- createSqlitePool ":memory:" 10 -- create a new pool
    -- perform any necessary migration
    runSqlPersistMPool (runMigration migrateAll) pool
    manager <- newManager def            -- create a new HTTP manager
    logger <- mkLogger True stdout       -- create Logger
    warpEnv $ Ember pool manager logger  -- start our server
