{-# LANGUAGE OverloadedStrings #-}

module Site (makeSite) where

-- import           Data.Monoid (mappend)
-- import           Control.Arrow ((>>>))
import           Hakyll
import           System.FilePath

-------------------------------------------------------------------
makeSite :: Identifier -> [Identifier] -> IO ()
-------------------------------------------------------------------
makeSite pageT tops = hakyll $ do
  match "static/*" copyDir

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match "js/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "templates/*"  $
    compile templateCompiler

  match (fromList tops) $
    makeHtml pageT

copyDir :: Rules ()
copyDir = do
  route   idRoute
  compile copyFileCompiler

makeHtml :: Identifier -> Rules ()
makeHtml pageT
  = do route   $ customRoute $ tx . toFilePath
       compile $ pandocCompiler
         >>= loadAndApplyTemplate pageT defaultContext
         >>= relativizeUrls
    where
      tx =  ( `replaceExtension` "html") . takeFileName
