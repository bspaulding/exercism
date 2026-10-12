module Sublist exposing (..)

import List exposing (..)


version : Int
version =
    2


type ListComparison
    = Equal
    | Unequal
    | Sublist
    | Superlist


isSublist : List a -> List a -> Bool
isSublist xs ys =
    case (isEmpty xs) || (isEmpty ys) of
        True ->
            False

        False ->
            xs == take (length xs) ys || isSublist xs (drop 1 ys)


sublist : List a -> List a -> ListComparison
sublist xs ys =
    if xs == ys then
        Equal
    else if isEmpty xs then
        Sublist
    else if isEmpty ys then
        Superlist
    else if isSublist xs ys then
        Sublist
    else if isSublist ys xs then
        Superlist
    else
        Unequal