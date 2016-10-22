{-# LANGUAGE OverloadedStrings #-}

module Firebase where
  
import Types
import Constants
import Data.Aeson
import Network.Wreq
import Control.Lens

cleanup :: IO()
cleanup = do
  print ("Cleaning up Firebase..." :: String)
  response <- delete urlFirebase
  print (response ^. responseStatus ^. statusMessage)

send :: [Event] -> IO ()
send events = do
  print ("Uploading data to Firebase..." :: String)
  response <- put urlFirebase (encode events)
  print (response ^. responseStatus ^. statusMessage)
