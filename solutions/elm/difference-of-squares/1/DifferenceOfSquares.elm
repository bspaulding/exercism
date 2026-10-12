module DifferenceOfSquares exposing (..)

square : Int -> Int
square x = x^2

squareOfSum : Int -> Int
squareOfSum x = List.range 0 x |> List.sum |> square

sumOfSquares : Int -> Int
sumOfSquares x = List.range 0 x |> List.map square |> List.sum

difference : Int -> Int
difference x = (squareOfSum x) - (sumOfSquares x)