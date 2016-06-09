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
  Event (getName html) (getDistance html) "" ""

getName :: Element -> String
getName html =
  let h3:_  = findElements (unqual "h3") $ html
      a:_   = findElements (unqual "a") $ h3
  in strContent a

getDistance :: Element -> String
getDistance html =
  let dl:_ = findElements (unqual "dl") $ html
      li:_ = findElements (unqual "li") $ dl
  in strContent li
      
data Event = Event {
  name :: String, 
  distance :: String, 
  location :: String, 
  url :: String
} deriving (Show)
