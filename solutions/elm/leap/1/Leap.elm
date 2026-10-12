module Leap exposing (..)

isLeapYear : Int -> Bool
isLeapYear n =
  if n % 4 /= 0 then False
  else if n % 100 /= 0 then True
  else if n % 400 /= 0 then False
  else True