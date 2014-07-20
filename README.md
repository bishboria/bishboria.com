----


Hello Scotty
============

Part of [Haskell on Heroku][].

This is an example [Haskell][] web app using the [Scotty][] web framework, intended to be deployed on [Heroku][].


Quick start
-----------

With [Heroku Toolbelt][] and [Git][] installed, try:

1.  Clone this app:

        git clone https://github.com/mietek/haskell-on-heroku-examples.git
        mv haskell-on-heroku-examples/hello-scotty .
        cd hello-scotty

2.  Commit the app to a new Git repo:

        git init
        git add .
        git commit -m "Initial commit"

3.  Create a new Heroku app:

        heroku create -b https://github.com/mietek/haskell-on-heroku.git

4.  Deploy the app on Heroku:

        time git push heroku master
        heroku ps:scale web=1
        heroku open


Start from scratch
------------------

The following steps show how to reproduce this example app from scratch.  [GHC][], [Cabal][], [Heroku Toolbelt][] and [Git][] are required.

1.  Write the app:

        mkdir hello-scotty
        cd hello-scotty
        cat >Main.hs <<EOF
        {-# LANGUAGE OverloadedStrings #-}

        import System.Environment
        import Web.Scotty

        main :: IO ()
        main = do
            port <- getEnv "PORT"
            scotty (read port) $
              get "/" $
                text "Hello, world!"
        EOF

2.  Write a new Cabal package description file:

        cat >hello-scotty.cabal <<EOF
        name:                           hello-scotty
        version:                        0.1
        build-type:                     Simple
        cabal-version:                  >= 1.10

        executable hello-scotty
          main-is:                      Main.hs
          default-language:             Haskell2010
          ghc-options:                  -O2
                                        -Wall
                                        -funbox-strict-fields
                                        -fwarn-tabs
                                        -threaded
          build-depends:
            base                        >= 4.6 && < 4.8,
            scotty                      >= 0.7 && < 0.8
        EOF

3.  Install app dependencies in a new Cabal sandbox.  This may take a few minutes:

        cabal update
        cabal sandbox init
        cabal install --dependencies-only

4.  Create a new Cabal configuration file to use explicit constraints for app dependencies:

        cabal freeze

5.  Work around a Cabal issue:

        awk '!/hello-scotty/' <cabal.config >tmp
        mv tmp cabal.config

6.  Build and run the app:

        cabal build
        PORT=8000 cabal run &

7.  Wait for the app to start, test the app, then stop the app:

        curl http://localhost:8000
        kill %%

8.  Commit the app to a new Git repo:

        git init
        cat >.gitignore <<EOF
        .cabal-sandbox
        cabal.sandbox.config
        dist
        EOF
        git add .
        git commit -m "Initial commit"

9.  Create a new Heroku app:

        heroku create -b https://github.com/mietek/haskell-on-heroku.git

10.  Deploy the app on Heroku:

        time git push heroku master
        heroku ps:scale web=1
        heroku open


Questions
---------

###  I have questions.  What now?

For answers, check the main [Haskell on Heroku][] documentation.


###  I still have questions.  Can I ask you a question?

Yes.  [Least Fixed][] offers commercial support for Haskell on Heroku.  Say hello@leastfixed.com


Meta
----

Written by [Miëtek Bak][].  Say hello@mietek.io

Available under the MIT License.


----

[Haskell on Heroku]:            https://github.com/mietek/haskell-on-heroku
[Haskell]:                      http://www.haskell.org
[Scotty]:                       https://github.com/scotty-web/scotty
[Heroku]:                       https://www.heroku.com

[Heroku Toolbelt]:              https://toolbelt.herokuapp.com
[Git]:                          http://git-scm.com
[GHC]:                          http://www.haskell.org/ghc
[Cabal]:                        http://www.haskell.org/cabal/download.html

[Least Fixed]:                  http://leastfixed.com
[Miëtek Bak]:                   http://mietek.io
