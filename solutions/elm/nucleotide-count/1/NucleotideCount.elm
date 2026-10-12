module NucleotideCount exposing (..)

import Char


version : Int
version =
    2


reducer c counts =
    case Char.toLower c of
        'a' ->
            { counts | a = counts.a + 1 }

        't' ->
            { counts | t = counts.t + 1 }

        'c' ->
            { counts | c = counts.c + 1 }

        'g' ->
            { counts | g = counts.g + 1 }

        _ ->
            counts


nucleotideCounts =
    String.foldl reducer { a = 0, t = 0, c = 0, g = 0 }