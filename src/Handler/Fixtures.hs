module Handler.Fixtures where

import Init

getFixturesR :: Handler Value
getFixturesR = do
    user <- runDB $ insert $ User "mkrull" "m.krull@uninets.eu"
    now <- liftIO getCurrentTime
    runDB $ insert_ $ Entry user ("A nice Blog entry" :: Text) ("This is a nice blog entry for testing BlogHa" :: Text ) now
    runDB $ insert_ $ Entry user ("Another nice Blog entry" :: Text) ("This is a another nice blog entry for testing BlogHa" :: Text ) now
    return $ object [ "status" .= ("200" :: Text) ]
