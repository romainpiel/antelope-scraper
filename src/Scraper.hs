module Scraper where

import Text.XML.Light
import Data.Maybe

main :: IO ()
main = putStrLn "hello"

findEventsHtml :: String -> IO [Event]
findEventsHtml xmlFile = do
  case parseXMLDoc xmlFile of
    Nothing   -> error "Failed to parse xml"
    Just doc  -> 
      let days   = findElements (unqual "day") $ doc
          events = concatMap dayToEvents days
      in return events

dayToEvents :: Element -> [Event]
dayToEvents day =
  let firstDate:_      = findElements (unqual "date") $ day
      firstDateContent = strContent firstDate
      xmlEvents        = findElements (unqual "event") $ day
      cdataContainers  = map elContent xmlEvents
      cdatas           = concatMap onlyText cdataContainers
      cdataContents    = map cdData cdatas
      rawEvents        = map (\cdata -> RawEvent firstDateContent cdata) cdataContents
      events           = map htmlContentToEvent rawEvents
  in events

htmlContentToEvent :: RawEvent -> Event
htmlContentToEvent rawEvent =
  let body  = "<body>" ++ (rcdata rawEvent) ++ "</body>"
  in case parseXMLDoc body of
    Nothing   -> error "Failed to parse xml"
    Just html  -> 
      Event (rdate rawEvent) (getName html) (getDistance html) (getLocation html) (getUrl html)

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

getLocation :: Element -> String
getLocation html =
  let ul:_ = findElements (unqual "ul") $ html
      li:_ = findElements (unqual "li") $ ul
  in strContent li

getUrl :: Element -> String
getUrl html =
  let _:dl:_ = findElements (unqual "dl") $ html
      maybeA = findElement (unqual "a") $ dl
      href   = case maybeA of
                Just a  -> fromJust (findAttr (unqual "href") $ a)
                Nothing -> ""
  in href

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
