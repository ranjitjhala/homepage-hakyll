--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Applicative ((<$>), empty)
import           Data.Monoid         (mappend)
import           Data.Set            (delete)
import           Hakyll

import Text.Pandoc.Definition
import Text.Pandoc.Shared
import Text.Pandoc.Options

--------------------------------------------------------------------------------
-- Used to specify whether to take all or some of an item list
data ItemCount = All | Only Int
data Navigation = Main | Blog

navCtx :: Navigation -> Context a
navCtx Main = constField "isNavMain" "true"
navCtx Blog = constField "isNavBlog" "true"

--------------------------------------------------------------------------------
destDir = "/Users/rjhala/personal/homepage-hakyll/_site/"

remote = "rjhala@goto.ucsd.edu"

siteConfig = defaultConfiguration
  { destinationDirectory  = destDir,
    storeDirectory        = "/Users/rjhala/tmp/hakyll_cache/",
    deployCommand         = "rsync -av --rsh='ssh -p1022' "
                            ++ destDir ++ " " ++ remote
  }

--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith siteConfig $ do
  -----------------
  -- Templates
  match "_templates/**" $ compile templateCompiler

  -----------------
  -- CSS
  match "css/**" $ do
    route   $ idRoute
    compile $ compressCssCompiler

  -----------------
  -- Static Content (including .htaccess)
  match "_static/**" $ do
    route   $ gsubRoute "_static/" (const "")
    compile $ copyFileCompiler

  -----------------
  -- 404 Page
  match "404.md" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Home"

  -----------------
  -- Home
  match "index.markdown" $ do
    route   $ setExtension "html"
    compile $ listCompiler "posts" postCtx (Only 3) "blog/posts/*"
              >>= pageCompiler "Home"

  -----------------
  -- Info
  match "info/*.markdown" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Info"

  -----------------
  -- Code
  match "code/**.markdown" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Code"

  -----------------
  -- Play
  match "play/**.md" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Play"
  -----------------
  -- Work

  -- News (Note: posts are *.md, index is index.markdown)
  match "work/news/*.md" $ compile bareCompiler
  match "work/news/index.markdown" $ do
    route   $ setExtension "html"
    compile $ listCompiler "posts" dateCtx All "work/news/*.md"
              >>= pageCompiler "Work"

  match "work/index.markdown" $ do
    route   $ setExtension "html"
    compile $ listCompiler "posts" dateCtx (Only 3) "work/news/*.md"
              >>= pageCompiler "Work"
  -- Teaching
  match "work/comp/**.md" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Teach"

  -- Vita
  match "work/vita/*.md" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Vita"

  -- Publications
  match "work/pubs/**.markdown" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Work"

  -- Machine Learning via Market Mechanisms Project
  match "work/mlmm/*" $ do
    route   $ setExtension "html"
    compile $ myPandocCompiler >>= pageCompiler "Work"

  -----------------
  -- Notes
  match "work/note/*.bib" $ compile $ biblioCompiler
  match "work/note/*.csl" $ compile $ cslCompiler

  -- match "work/note/**.markdown" $ do
  --   route   $ setExtension "html"
  --   compile $ bibtexCompiler >>= pageCompiler "Work"

  -- NUKE -----------------
  -- NUKE -- Blog
  -- NUKE match "blog/index.markdown" $ do
  -- NUKE   route   $ setExtension "html"
  -- NUKE   compile $ listCompiler "posts" postCtx (Only 5) "blog/posts/*"
  -- NUKE             >>= blogPageCompiler "Home"

  -- NUKE match "blog/past.markdown" $ do
  -- NUKE   route   $ setExtension "html"
  -- NUKE   compile $ listCompiler "posts" postCtx All "blog/posts/*"
  -- NUKE             >>= blogPageCompiler "Home"

  -- NUKE match "blog/info.markdown" $ do
  -- NUKE   route   $ setExtension "html"
  -- NUKE   compile $ myPandocCompiler >>= blogPageCompiler "Info"

  -- NUKE match "blog/kith.markdown" $ do
  -- NUKE   route   $ setExtension "html"
  -- NUKE   compile $ myPandocCompiler >>= blogPageCompiler "Kith"

  -- NUKE -- Posts
  -- NUKE match "blog/posts/*" $ do
  -- NUKE   route   $ gsubRoute "posts" (const "") `composeRoutes` rmDateRoute
  -- NUKE   compile $ blogPostCompiler True

  -- NUKE -- Drafts
  -- NUKE match "blog/drafts/*" $ do
  -- NUKE   route   $ rmDateRoute
  -- NUKE   compile $ blogPostCompiler False

  -- NUKE -----------------
  -- NUKE -- Testing
  -- NUKE match "blog/test/*.md" $ do
  -- NUKE   route   $ gsubRoute "test" (const "") `composeRoutes` rmDateRoute
  -- NUKE   compile $ blogPostCompiler False

--------------------------------------------------------------------------------
-- Compile pages by wrapping in standard templates
pageCompiler :: String -> Item String -> Compiler (Item String)
pageCompiler section item =
    loadAndApplyTemplate "_templates/page.html"         homeCtx item
    >>= loadAndApplyTemplate "_templates/nav/main.html" homeCtx
    >>= loadAndApplyTemplate "_templates/main.html"     homeCtx
    >>= loadAndApplyTemplate "_templates/bottom.html"   homeCtx
    >>= loadAndApplyTemplate "_templates/top.html"      homeCtx
    >>= relativizeUrls
    where
      homeCtx = pageCtx section

-- Compile pages with Pandoc's citations resolved against a BibTeX file
-- bibtexCompiler = do
--   csl <- load "work/note/siggraph.csl"
--   bib <- load "work/note/refs.bib"

--   getResourceBody
--     >>= readPandocBiblio def (Just csl) bib
--     >>= return . writePandoc

-- Compile a page that include template code to show a list
-- listCompiler :: String -> Context String -> ItemCount -> String -> Compiler (Item String)
listCompiler field listItemCtx number listItemId = do
  let posts = takeRecentFirst number =<< loadAll listItemId
  let listCtx = listField field listItemCtx posts `mappend` defaultContext

  noMathsCompiler >>= applyAsTemplate listCtx


-- Blog posts
-- Take out the post/YYYY-MM-DD part from the post URL
rmDateRoute =
  gsubRoute "/[0-9]{4}-[0-9]{2}-[0-9]{2}-" (const "/")
  `composeRoutes` setExtension "html"

-- Blog page compiler
blogPageCompiler section item =
    loadAndApplyTemplate "_templates/page.html" postCtx item
    >>= loadAndApplyTemplate "_templates/nav/blog.html" postCtx
    >>= loadAndApplyTemplate "_templates/disqus/counts.html" postCtx
    >>= loadAndApplyTemplate "_templates/main.html" postCtx
    >>= loadAndApplyTemplate "_templates/bottom.html" (pageCtx section)
    >>= loadAndApplyTemplate "_templates/top.html" postCtx
    >>= relativizeUrls

-- News index compiler
-- newsRecentsCompiler n tplID = recentsCompiler "work/news/*.md" n tplID dateCtx

-- Blog index compiler
-- blogRecentsCompiler n tplID = recentsCompiler "blog/posts/*" n tplID postCtx

-- Blog post compiler
blogPostCompiler snapshot = mathJaxRenderer
  >>= loadAndApplyTemplate "_templates/post/body.html" postCtx
  >>= (if snapshot then (saveSnapshot "content") else return . id)
  >>= loadAndApplyTemplate "_templates/post/full.html" postCtx
  >>= loadAndApplyTemplate "_templates/disqus/thread.html" postCtx
  >>= loadAndApplyTemplate "_templates/nav/blog.html" postCtx
  >>= loadAndApplyTemplate "_templates/main.html" postCtx
  >>= loadAndApplyTemplate "_templates/bottom.html" postCtx
  >>= loadAndApplyTemplate "_templates/post/twitter-summary.html" postCtx
  >>= loadAndApplyTemplate "_templates/top.html" postCtx
  >>= relativizeUrls

-- Pandoc render with MathJax enabled
mathJaxRenderer =
  pandocCompilerWith readerConfig writerConfig { writerHTMLMathMethod = MathJax "" }

-- Set various fields for front pages
pageCtx :: String -> Context String
pageCtx section =
  constField "top" "Mark Reid" `mappend`
  constField "section" section `mappend`
  defaultContext

dateCtx :: Context String
dateCtx =
  dateField "date" "%B %e, %Y" `mappend`
  dateField "shortdate" "%e %b %y" `mappend`
  defaultContext

-- Set various fields for blog posts
postCtx :: Context String
postCtx =
  constField "top" "Inductio Ex Machina &larr; Mark Reid" `mappend`
  constField "section" "Blog" `mappend`
  dateCtx

--------------------------------------------------------------------------------
-- Helper functions

-- Create a function that either takes n or all of a list
maybeTake :: ItemCount -> [a] -> [a]
maybeTake All  = id
maybeTake (Only n) = take n

-- Sort list of items in reverse chronological order then take first n
takeRecentFirst n = fmap (maybeTake n) . recentFirst

-- Pandoc compiler with defaults I like
writerConfig = def
readerConfig = def { readerSmart = True, readerOldDashes = True }
writerNoMaths = def
readerNoMaths = def {
    readerExtensions = delete Ext_tex_math_dollars (readerExtensions readerConfig)
  }

noMathsCompiler = pandocCompilerWith readerNoMaths writerNoMaths
myPandocCompiler = pandocCompilerWith readerConfig writerConfig
bareCompiler = pandocCompilerWithTransform readerConfig writerConfig stripPara

stripPara :: Pandoc -> Pandoc
stripPara (Pandoc meta [ (Para inline) ]) = Pandoc meta [ Plain inline ]
stripPara (Pandoc meta blocks) = Pandoc meta blocks
