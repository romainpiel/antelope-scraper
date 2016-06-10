module Main where

import Parser

-- temporary for testing
-- main :: IO ()
main :: IO [Event]
main = do
  f <- readFile "tests/london.xml"
  Parser.findEventsHtml f
