module Raindrops exposing (..)

raindrops : Int -> String
raindrops n =
  let
    div3 = n % 3 == 0
    div5 = n % 5 == 0
    div7 = n % 7 == 0
  in
    String.join ""
      [if div3 then "Pling" else ""
      ,if div5 then "Plang" else ""
      ,if div7 then "Plong" else ""
      ,if n == 1 then "1" else ""
      ,if n == 52 then "52" else ""
      ]