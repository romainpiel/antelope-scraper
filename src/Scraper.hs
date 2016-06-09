module Scraper where

import Text.XML.Light

main :: IO ()
main = putStrLn "hello"

findEventsHtml :: String -> IO [Event]
findEventsHtml xmlFile = do
  case parseXMLDoc xmlFile of
    Nothing   -> error "Failed to parse xml"
    Just doc  -> 
      let xmlEvents        = findElements (unqual "event") $ doc
          cdataContainers  = map elContent xmlEvents
          cdatas           = concatMap onlyText cdataContainers
          cdataContents    = map cdData cdatas
          events           = map htmlContentToEvent cdataContents
      in return events

htmlContentToEvent :: String -> Event
htmlContentToEvent html =
  case parseXMLDoc html of
    Nothing   -> error "Failed to parse xml"
    Just doc  -> htmlToEvent doc
      
htmlToEvent :: Element -> Event
htmlToEvent html =
  let title = "a"
  in Event title "" "" ""
      
data Event = Event {
  name :: String, 
  distance :: String, 
  location :: String, 
  url :: String
} deriving (Show)
