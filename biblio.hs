{-# LANGUAGE OverloadedStrings #-}

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

-------------------------------------------------------------------
-- | Generate Output ----------------------------------------------
-------------------------------------------------------------------

main :: IO ()
main = mkBibHtml tpltF bibF outF
  where
    tpltF = "examples/bib.html"
    bibF  = "examples/bib.json"
    outF  = "dist/output.html"

mkBibHtml tpltF bibF outF = do
  tplStr <- TIO.readFile tpltF
  bib    <- readBib    bibF
  let htmlStr = K.renderTemplate bib tplStr
  TIO.writeFile outF htmlStr

readBib :: FilePath -> IO BibValue
readBib f = do
  b <- eitherDecode' <$> LB.readFile f
  case b of
    Left err -> error err
    Right v  -> return $ bibValue v

bibValue :: [Pub] -> BibValue
bibValue ps = H.fromList [ ("pubs", toVal ps)]

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

