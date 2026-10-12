module ETL (transform) where

import qualified Data.List
import Data.Map (Map, empty, foldlWithKey, insert)
import Data.Char (toLower)

reduceStr :: Int -> Map Char Int -> Char -> Map Char Int
reduceStr key acc value = insert (toLower value) key acc

reducer :: Map Char Int -> Int -> String -> Map Char Int
reducer acc key value =
  Data.List.foldl (reduceStr key) acc value

transform :: Map Int String -> Map Char Int
transform legacyData =
  foldlWithKey reducer empty legacyData
