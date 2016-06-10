module Types where

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
