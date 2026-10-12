module SumOfMultiples exposing (..)

isMultiple : Int -> Int -> Bool
isMultiple x y = y % x == 0

isAnyMultiple : List Int -> Int -> Bool
isAnyMultiple xs y =
  List.any (\x -> isMultiple x y) xs

sumOfMultiples : List Int -> Int -> Int
sumOfMultiples xs y =
  List.range 0 (y - 1)
  |> List.filter (isAnyMultiple xs)
  |> List.sum