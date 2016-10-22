module Main where

import Source
import Parser
import Firebase

main :: IO ()
main = do
  html <- Source.getData
  events <- Parser.findEventsHtml html
  Firebase.cleanup
  Firebase.send events
