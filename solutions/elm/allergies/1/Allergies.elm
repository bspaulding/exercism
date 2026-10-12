module Allergies exposing (..)

import Bitwise
import Dict


allergyBitMap =
    Dict.empty
        |> Dict.insert "eggs" 1
        |> Dict.insert "peanuts" 2
        |> Dict.insert "shellfish" 4
        |> Dict.insert "strawberries" 8
        |> Dict.insert "tomatoes" 16
        |> Dict.insert "chocolate" 32
        |> Dict.insert "pollen" 64
        |> Dict.insert "cats" 128


isAllergicTo : String -> Int -> Bool
isAllergicTo allergy x =
    case Dict.get allergy allergyBitMap of
        Nothing ->
            False

        Just bit ->
            0 /= (Bitwise.and bit x)


toList : Int -> List String
toList x =
    Dict.keys allergyBitMap
        |> List.filter (\allergy -> isAllergicTo allergy x)