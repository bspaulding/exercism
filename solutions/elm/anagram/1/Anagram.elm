module Anagram exposing (..)

import Dict

countsRecur : List comparable -> Dict.Dict comparable Int -> Dict.Dict comparable Int
countsRecur xs counts =
  case List.head xs of
    Nothing -> counts
    Just h ->
      case Dict.get h counts of
        Nothing ->
          let
            newCounts = Dict.insert h 1 counts
          in
            case List.tail xs of
              Nothing -> newCounts
              Just t -> countsRecur t newCounts
        Just count ->
          let
            newCounts = Dict.insert h (count + 1) counts
          in
            case List.tail xs of
              Nothing -> newCounts
              Just t -> countsRecur t newCounts

counts : List comparable -> Dict.Dict comparable Int
counts xs = countsRecur xs Dict.empty

isAnagram : String -> String -> Bool
isAnagram a b =
  let
    lowerA = String.toLower a
    lowerB = String.toLower b
  in
    if lowerA == lowerB then
      False
    else
      (lowerA |> String.toList |> counts) == (lowerB |> String.toList |> counts)

detect : String -> List String -> List String
detect s = isAnagram s |> List.filter