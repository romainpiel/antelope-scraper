{-# LANGUAGE OverloadedStrings #-}

module Firebase where
  
import Types
import Constants
import Data.Aeson
import Network.Wreq
import Control.Lens

send :: [Event] -> IO ()
send events = do
  print ("Uploading data to Firebase..." :: String)
  response <- put urlFirebase (encode events)
  print (response ^. responseStatus ^. statusMessage)
