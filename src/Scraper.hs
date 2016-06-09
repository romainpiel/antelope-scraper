module Scraper where

import Text.XML.Light

main :: IO ()
main = putStrLn "hello"

findEventsHtml :: String -> IO [String]
findEventsHtml xmlFile = do
  case parseXMLDoc xmlFile of
    Nothing   -> error "Failed to parse xml"
    Just doc  -> 
      let events            = findElements (unqual "event") $ doc
          cdata_containers  = map elContent events
          cdatas            = concatMap onlyText cdata_containers
          cdata_contents    = map cdData cdatas
      in return cdata_contents
