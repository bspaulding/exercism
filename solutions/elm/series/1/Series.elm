module Series exposing (..)

import Debug exposing (log)


charToInt : Char -> Result String Int
charToInt c =
    toString c |> String.toInt


stringToIntList : List Int -> String -> Result String (List Int)
stringToIntList xs s =
    if String.isEmpty s then
        Ok xs
    else
        case String.toInt (String.left 1 s) of
            Err s ->
                Err s

            Ok x ->
                stringToIntList (xs ++ [ x ]) (String.dropLeft 1 s)


partition : Int -> List a -> List (List a) -> List (List a)
partition x xs ys =
    if List.length xs < x then
        ys
    else
        partition x (List.drop 1 xs) (ys ++ [ List.take x xs ])


slices : Int -> String -> Result String (List (List Int))
slices n s =
    if n == 0 then
        Err "Invalid size: 0"
    else
        case stringToIntList [] s of
            Err s ->
                Err s

            Ok xs ->
                Ok (partition n xs [])