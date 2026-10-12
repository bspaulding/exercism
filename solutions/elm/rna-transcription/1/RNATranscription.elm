module RNATranscription exposing (..)

import Dict

dnaToRnaDict : Dict.Dict Char String
dnaToRnaDict = Dict.empty
  |> Dict.insert 'C' "G"
  |> Dict.insert 'G' "C"
  |> Dict.insert 'T' "A"
  |> Dict.insert 'A' "U"

dnaToRna : Char -> Result Char String
dnaToRna dna =
  case Dict.get dna dnaToRnaDict of
    Just rna -> Ok rna
    Nothing -> Err dna

dropErrorsRecur : List (Result error value) -> List value -> List value
dropErrorsRecur xs ys =
  case (List.head xs, List.tail xs) of
    (Just (Ok h), Just t) -> dropErrorsRecur t (ys ++ [h])
    (_, _) -> ys

dropErrors : List (Result error value) -> List value
dropErrors  xs = dropErrorsRecur xs []

getFirstError : List (Result error value) -> Maybe error
getFirstError xs =
  case (List.head xs, List.tail xs) of
    (Just (Err e), Just t) -> Just e
    (_, _) -> Nothing

toRNA : String -> Result Char String
toRNA dna =
  let
    rnas = List.map dnaToRna <| String.toList dna
  in
    case getFirstError rnas of
      Just e -> Err e
      Nothing -> Ok <| String.join "" (dropErrors rnas)