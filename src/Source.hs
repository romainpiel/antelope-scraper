module Source where

import Constants
import Network.Wreq
import Control.Lens
import Data.ByteString.Lazy (ByteString)

getData :: IO (ByteString)
getData = do
  response <- get urlSource
  return $ response ^. responseBody
