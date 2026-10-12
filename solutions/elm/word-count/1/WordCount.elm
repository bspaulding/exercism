module WordCount exposing (..)

import Dict exposing (Dict, empty, insert, get)
import List exposing (head, tail, map)
import Regex exposing (regex, replace, split)
import String exposing (toLower, trim)

getDefault : comparable -> a -> Dict comparable a -> a
getDefault k v d =
  case get k d of
    Just v -> v
    Nothing -> v

countRecur : Dict String Int -> List String -> Dict String Int
countRecur counts xs =
  case (head xs, tail xs) of
    (Just h, Just t) ->
      let
        x = getDefault h 0 counts
        newCounts = insert h (x + 1) counts
      in
        countRecur newCounts t
    (_, _) -> counts

words : String -> List String
words s =
  replace Regex.All (regex "\\W+") (\_ -> " ") s
  |> trim
  |> split Regex.All (regex "\\s+")

wordCount : String -> Dict String Int
wordCount s = words s |> map toLower |> countRecur empty