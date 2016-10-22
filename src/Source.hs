module Source where

import Constants
import Network.Wreq
import Control.Lens
import Data.ByteString.Lazy (ByteString)

getData :: IO (ByteString)
getData = do
  print ("Downloading source data..." :: String)
  response <- get urlSource
  print (response ^. responseStatus ^. statusMessage)
  return $ response ^. responseBody
