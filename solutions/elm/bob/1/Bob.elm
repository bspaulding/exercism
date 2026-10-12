module Bob exposing (..)

import Regex

isSpace : Char -> Bool
isSpace c =
  case c of
    ' ' -> True
    '\t' -> True
    '\n' -> True
    _ -> False

isEmpty : String -> Bool
isEmpty = String.all isSpace

isQuestion : String -> Bool
isQuestion s = String.dropLeft (String.length s - 1) s == "?"

isAllCaps : String -> Bool
isAllCaps s = String.toUpper s == s

sanitizer : String -> String
sanitizer = Regex.replace Regex.All (Regex.regex "[^a-zA-Z]") (\_ -> "")

isShouting : String -> Bool
isShouting msg =
  let
    sanitized = sanitizer msg
  in
    not (isEmpty sanitized) && isAllCaps sanitized

hey : String -> String
hey msg =
    if isShouting msg then
      "Whoa, chill out!"
    else if isQuestion msg then
      "Sure."
    else if isEmpty msg then
      "Fine. Be that way!"
    else
      "Whatever."