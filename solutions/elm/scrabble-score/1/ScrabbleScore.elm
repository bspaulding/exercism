module ScrabbleScore exposing (..)

import Dict

pointsByLetter : Dict.Dict Char Int
pointsByLetter = Dict.empty
  |> Dict.insert 'a' 1
  |> Dict.insert 'b' 3
  |> Dict.insert 'c' 3
  |> Dict.insert 'd' 2
  |> Dict.insert 'e' 1
  |> Dict.insert 'f' 4
  |> Dict.insert 'g' 3
  |> Dict.insert 'h' 4
  |> Dict.insert 'i' 1
  |> Dict.insert 'j' 8
  |> Dict.insert 'k' 5
  |> Dict.insert 'l' 1
  |> Dict.insert 'm' 3
  |> Dict.insert 'n' 1
  |> Dict.insert 'o' 1
  |> Dict.insert 'p' 3
  |> Dict.insert 'q' 10
  |> Dict.insert 'r' 1
  |> Dict.insert 's' 1
  |> Dict.insert 't' 1
  |> Dict.insert 'u' 1
  |> Dict.insert 'v' 4
  |> Dict.insert 'w' 4
  |> Dict.insert 'x' 8
  |> Dict.insert 'y' 4
  |> Dict.insert 'z' 10

pointsForLetter : Char -> Int
pointsForLetter c =
  case Dict.get c pointsByLetter of
    Just x -> x
    Nothing -> 0

scoreWord : String -> Int
scoreWord s = List.sum <| List.map pointsForLetter <| String.toList <| String.toLower s