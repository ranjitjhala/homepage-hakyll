{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text.IO as TIO
import           Control.Monad ((>=>))
import           Biblio
import           Site
import           Misc
import           System.FilePath ((</>))
import           Hakyll

main :: IO ()
main = do
  putStrLn "Building Site"
  mkBib bibT bibF pubsF
  concatFiles [pResF, pubsF] (toFilePath bResF)
  makeSite pageT tops

--------------------------------------------------------------------------------
-- | Paths
--------------------------------------------------------------------------------

-- | Templates
pageT = "templates/page.template"
bibT  = "templates/bib.template"
bibF  = "templates/jhala-bib.json"

-- | Pages Files
tops  :: [Identifier]
tops  = [ "pages/index.markdown"
        , "pages/teaching.markdown"
        , "pages/students.markdown"
        , "pages/video.markdown"
        , bResF
        ]

-- | Temporary Files
pubsF = "_build/pubs.markdown"

-- | Generated Files
bResF = "_build/research.markdown"
pResF = "pages/research.markdown"
