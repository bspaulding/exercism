module Triangle exposing (..)

import Set

type Triangle = Equilateral | Isosceles | Scalene

sides : comparable -> comparable -> comparable -> (comparable, comparable, comparable)
sides x y z =
  let
    ul = [x, y, z]
    ol = List.sort ul
    a = List.head ol
    b = List.head <| List.drop 1 ol
    c = List.head <| List.drop 2 ol
  in
    case (a, b, c) of
      (Just a, Just b, Just c) -> (a, b, c)
      _ -> (0, 0, 0)


triangleKind : comparable -> comparable -> comparable -> Result String Triangle
triangleKind x y z =
  let
    isInvalidLengths = List.any (\x -> x <= 0) [x, y, z]
    (a, b, c) = sides x y z
    isValidTriangle = c <= a + b
    ne = Set.size <| Set.fromList [x, y, z]
  in
    if isInvalidLengths then
      Err "Invalid lengths"
    else if isValidTriangle then
      case ne of
        1 -> Ok Equilateral
        2 -> Ok Isosceles
        3 -> Ok Scalene
        _ -> Err "Violates inequality"
    else
      Err "Violates inequality"

version : Int
version =
    2