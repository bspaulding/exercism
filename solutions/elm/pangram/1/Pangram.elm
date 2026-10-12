module Pangram exposing (..)

a2z : List String
a2z = ["a", "b", "c", "d", "e", "f", "g"
      ,"h", "i", "j", "k", "l","m", "n"
      ,"o", "p", "q", "r", "s", "t", "u"
      ,"v", "w", "x","y", "z"]

isPangram : String -> Bool
isPangram s =
  let
    lower = String.toLower s
  in
    List.all (\c -> String.contains c lower) a2z