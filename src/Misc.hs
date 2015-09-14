{-# LANGUAGE OverloadedStrings #-}

module Misc where

concatFiles :: [FilePath] -> FilePath -> IO ()
concatFiles fs outF = do
  removeExistFile outF
  forM fs $ TIO.readFile >=> TIO.appendFile outF

removeExistFile :: FilePath -> IO ()
removeExistFile f = do
  b <- doesFileExist f
  when b (removeFile f)
