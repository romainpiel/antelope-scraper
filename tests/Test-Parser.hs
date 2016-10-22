module Main where

import qualified Parser as P
import           Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Verify that findEventsHtml on london xml find the correct number of events" $ do
    it "equals 174" $ do
      london <- readFile "tests/london.xml"
      events <- P.findEventsHtml london
      (length events) `shouldBe` 174
