{-# LANGUAGE OverloadedStrings #-}

import System.Environment
import Web.Scotty

main :: IO ()
main = do
    port <- getEnv "PORT"
    scotty (read port) $
      get "/" $
        file "index.html"
