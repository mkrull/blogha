module Handler.Posts where

import Init

getPostsR :: Handler Value
getPostsR = do
    posts <- runDB $ selectList [ EntryTitle !=. "" ] []
    return $ beautifulJSON "posts" posts
    where
        beautifulJSON key val = object [ key .= toJSON (Prelude.map entityVal val) ]