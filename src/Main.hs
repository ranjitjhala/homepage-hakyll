{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text.IO as TIO
import           Control.Monad ((>=>))
import           Biblio
import           Site
import           Misc
import           System.FilePath ((</>))


main :: IO ()
main = do
  mkBib bibT bibF pubsF
  concatFiles [pResF, pubsF] bResF
  makeSite pageT tops

--------------------------------------------------------------------------------
-- | Paths
--------------------------------------------------------------------------------

-- | Templates
pageT = "templates/page.template"
bibT  = "templates/bib.template"
bibF  = "templates/jhala-bib.json"

-- | Temporary Files
pubsF = "_build/pubs.markdown"

-- | Pages Files
tops  = [ "pages/index.markdown"
        , "pages/teaching.markdown"
        , "pages/students.markdown"
        , "pages/video.markdown"
        , bResF
        ]

-- | Generated Files
bResF = "_build" </> resF
pResF = "pages"  </> resF
resF  = "research.markdown"
