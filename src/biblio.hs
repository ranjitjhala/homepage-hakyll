-- #!/usr/bin/env runhaskell


{-# LANGUAGE OverloadedStrings #-}

module Biblio (mkBib) where

import qualified Data.Text.IO        as TIO
import qualified Data.Text           as T
import qualified Data.Vector         as V
import           Data.Aeson.Types    hiding (Value)
import           Data.Aeson          (eitherDecode')
import qualified Text.Karver         as K
import qualified Data.HashMap.Strict as H
import           Control.Applicative
import           Control.Monad       (mzero)
import qualified Data.ByteString.Lazy as LB
import           System.Environment (getArgs)
import qualified Data.List as L

-------------------------------------------------------------------
-- | Generate Output ----------------------------------------------
-------------------------------------------------------------------

{-
main :: IO ()
main = do
  (tpltF:bibF:outF:_) <- getArgs
  mkBibHtml tpltF bibF outF
  -- where
-}

mkBib :: FilePath -> FilePath -> FilePath -> IO ()
mkBib tpltF bibF outF = do
  tplStr <- TIO.readFile tpltF
  ypubs  <- yearPubs <$> readBib bibF
  TIO.writeFile outF  $ renderYears ypubs tplStr

readBib :: FilePath -> IO [Pub]
readBib f = do
  b <- eitherDecode' <$> LB.readFile f
  case b of
    Left err -> error err
    Right v  -> return v

renderYears :: [(Int, BibValue)] -> T.Text -> T.Text
renderYears ibibs tplStr = T.concat [ K.renderTemplate bib tplStr | (i, bib) <- ibibs ]

yearPubs :: [Pub] -> [(Int, BibValue)]
yearPubs = L.sortBy orderByYear
         . H.toList
         . H.mapWithKey yearValue
         . groupByYear

groupByYear :: [Pub] -> H.HashMap Int [Pub]
groupByYear    = L.foldl' addPub H.empty
  where
    addPub m p = adds (year p) p m
    adds k v m = H.insert k (v : H.lookupDefault [] k m) m

yearValue :: Int -> [Pub] -> BibValue
yearValue i xs = H.fromList [ ("year", toVal i )
                            , ("pubs", toVal xs) ]

orderByYear (i,_) (j,_) = compare j i

-------------------------------------------------------------------
-- | JSON Format for Pubs -----------------------------------------
-------------------------------------------------------------------

type BibValue = H.HashMap T.Text K.Value

data Pub = Pub {
    title   :: T.Text
  , year    :: Int
  , venue   :: T.Text
  , short   :: T.Text
  , authors :: [T.Text]
  , url     :: T.Text
  }
  deriving (Eq, Ord, Show)

data Bib = Bib {
    pubs :: [Pub]
  }
  deriving (Eq, Ord, Show)

instance FromJSON Pub where
  parseJSON (Object v) = Pub <$> v .: "title"
                             <*> v .: "year"
                             <*> v .: "venue"
                             <*> v .: "short"
                             <*> v .: "authors"
                             <*> v .: "url"
  parseJSON _          = mzero

instance ToJSON Pub where
  toJSON p = object [ "title"   .= title   p
                    , "year"    .= year    p
                    , "venue"   .= venue   p
                    , "short"   .= short   p
                    , "authors" .= authors p
                    , "url"     .= url     p
                    ]

-------------------------------------------------------------------
-- | Convert to Karver Values -------------------------------------
-------------------------------------------------------------------

class ToValue a where
  toVal :: a -> K.Value

instance ToValue T.Text where
  toVal = K.Literal

instance ToValue Int where
  toVal = K.Literal . toText

toText   :: (Show a) => a -> T.Text
toText   = T.pack . show

manyText :: (Show a) => [a] -> T.Text
manyText = T.intercalate ", " . map toText

instance (ToValue a) => ToValue [a] where
  toVal = K.List . V.fromList . map toVal

instance ToValue Pub where
  toVal p = obj [ ("title"   , title   p)
                , ("venue"   , venue   p)
                , ("short"   , short   p)
                , ("url"     , url     p)
                , ("year"    , toText   $ year    p)
                , ("authors" , T.intercalate ", " $ authors p)
                ]
    where
      obj = K.Object . H.fromList
