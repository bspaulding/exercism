module Strain exposing (..)

filter : (comparable -> Bool) -> List comparable -> List comparable -> List comparable
filter f xs ys =
  if List.isEmpty xs then
    ys
  else
    case (List.head xs, List.tail xs) of
      (Just h, Just t) ->
        case f h of
          True -> filter f t (ys ++ [h])
          False -> filter f t ys
      (_, _) -> ys

keep : (comparable -> Bool) -> List comparable -> List comparable
keep f xs = filter f xs []

discard : (comparable -> Bool) -> List comparable -> List comparable
discard f xs = filter (\x -> not <| f x) xs []