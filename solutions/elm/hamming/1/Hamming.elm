module Hamming exposing (..)

acc : List Char -> List Char -> Int -> Int
acc xs ys n =
  case (List.head xs, List.tail xs, List.head ys, List.tail ys) of
    (Just hx, Just tx, Just hy, Just ty) ->
      let
        n1 = if hx == hy then 0 else 1
      in
        acc tx ty (n + n1)
    (_, _, _, _) -> n

distance : String -> String -> Maybe Int
distance a b =
  case String.length a == String.length b of
    True -> Just <| acc (String.toList a) (String.toList b) 0
    False -> Nothing