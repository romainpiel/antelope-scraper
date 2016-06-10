module Main where

import Parser
import Sender

-- temporary for testing
main :: IO ()
-- main :: IO String
main = do
  html <- readFile "tests/london.xml"
  events <- Parser.findEventsHtml html
  Sender.eventsToJson events
