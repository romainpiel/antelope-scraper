module Types where
  
import Data.Aeson.Types

data RawEvent = RawEvent {
  rdate :: String,
  rcdata :: String
} deriving (Show)

data Event = Event {
  date :: String,
  name :: String, 
  distance :: String, 
  location :: String, 
  url :: String
} deriving (Show)

instance ToJSON Event where
  toJSON (Event da n di l u) = object [ "date" .= da, "name" .= n, "distance" .= di, "location" .= l, "url" .= u ]
