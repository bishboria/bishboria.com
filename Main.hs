{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Data.Text
import System.Directory
import System.Environment
import System.FilePath
import Web.Scotty

main :: IO ()
main = do
    port  <- getEnv "PORT"

    scotty (read port) $ do
        get "/" $ do
            file "static/index.html"

        get "/style.css" $ do
            file "static/style.css"

        notFound $ file "static/404.html"
