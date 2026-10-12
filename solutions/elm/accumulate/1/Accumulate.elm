module Accumulate exposing (..)

import List exposing (isEmpty, tail, head)

acc : (a -> b) -> List a -> List b -> List b
acc f xs ys =
  if isEmpty xs then
    ys
  else
    let
      h = head xs
      t = tail xs
    in
      case (h, t) of
        (Just h, Just t) ->
          acc f t (ys ++ [(f h)])
        _ -> ys

accumulate : (a -> b) -> List a -> List b
accumulate f xs = acc f xs []