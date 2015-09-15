{-# LANGUAGE OverloadedStrings #-}

module Misc where

import qualified Data.Text.IO        as TIO
import Control.Monad
import System.Directory

concatFiles :: [FilePath] -> FilePath -> IO ()
concatFiles fs outF = do
  removeExistFile outF
  forM_ fs $ TIO.readFile >=> TIO.appendFile outF

removeExistFile :: FilePath -> IO ()
removeExistFile f = do
  b <- doesFileExist f
  when b (removeFile f)
