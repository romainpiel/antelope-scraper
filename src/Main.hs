module Main where

import Parser
import Firebase

-- temporary for testing
main :: IO ()
-- main :: IO String
main = do
  html <- readFile "tests/london.xml"
  events <- Parser.findEventsHtml html
  Firebase.send events
