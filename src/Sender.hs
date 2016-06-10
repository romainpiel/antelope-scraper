module Sender where

import Types
import Data.Aeson

eventsToJson :: [Event] -> IO ()
eventsToJson events = do
  print (encode events)
