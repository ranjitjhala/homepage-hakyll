{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid (mappend)
import           Control.Arrow ((>>>))
import           Hakyll
import           System.FilePath
import           Paths (tops)

-------------------------------------------------------------------
makeSite :: IO ()
-------------------------------------------------------------------
makeSite = hakyll $ do
  match "static/*" copyDir

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match "js/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "templates/*"  $
    compile templateCompiler

  match (fromList tops)
    makeHtml

copyDir = do
  route   idRoute
  compile copyFileCompiler

makeHtml
  = do route   $ customRoute $ tx . toFilePath
       compile $ pandocCompiler
         >>= loadAndApplyTemplate pageT  defaultContext
         >>= relativizeUrls
    where
      tx =  ( `replaceExtension` "html") . takeFileName
