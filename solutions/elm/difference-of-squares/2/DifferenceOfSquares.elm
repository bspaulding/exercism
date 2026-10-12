module DifferenceOfSquares exposing (..)

import List exposing (map, range, sum)

square : Int -> Int
square x = x^2

squareOfSum : Int -> Int
squareOfSum x = range 0 x |> sum |> square

sumOfSquares : Int -> Int
sumOfSquares x = range 0 x |> map square |> sum

difference : Int -> Int
difference x = (squareOfSum x) - (sumOfSquares x)