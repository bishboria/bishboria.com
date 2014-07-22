{-# LANGUAGE OverloadedStrings #-}

import System.Environment
import Web.Scotty

main :: IO ()
main = do
    port <- getEnv "PORT"

    scotty (read port) $ do
        get "/" $ do
            file "index.html"

        get "/posts/:post" $ do
            post <- param "post"
            file (post ++ ".html")
