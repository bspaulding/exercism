module Anagram (anagramsFor) where

import qualified Data.List
import qualified Data.Map
import Data.Char (toLower)

updateCount :: Data.Map.Map Char Int -> Char -> Data.Map.Map Char Int
updateCount acc k = Data.Map.insert k (v + 1) acc
  where v = Data.Map.findWithDefault 0 k acc

charCounts :: String -> Data.Map.Map Char Int
charCounts xs =
  Data.List.foldl updateCount Data.Map.empty xs

isAnagram :: String -> String -> Bool
isAnagram x y = not (x' == y') && charCounts x' == charCounts y'
  where x' = map toLower x
        y' = map toLower y

anagramsFor :: String -> [String] -> [String]
anagramsFor xs = filter (isAnagram xs)
