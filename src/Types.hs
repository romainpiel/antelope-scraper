{-# LANGUAGE OverloadedStrings #-}

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
  shape :: String, 
  terrain :: String, 
  location :: String, 
  url :: String
} deriving (Show)

instance ToJSON Event where
  toJSON (Event da n di sh te l u) = object [ "date" .= da, "name" .= n, "distance" .= di, "shape" .= sh, "terrain" .= te, "location" .= l, "url" .= u ]
