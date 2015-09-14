
{-# LANGUAGE OverloadedStrings #-}

module Paths where

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
