module RunLengthEncoding exposing (..)

import Regex exposing (replace, HowMany(..), Match, regex)

collapseMatch : Match -> String
collapseMatch { match } =
  let
    n = String.length match
  in
    (toString n) ++ (String.slice 0 1 match)

encode : String -> String
encode = replace All (regex "(.)\\1{1,}") collapseMatch

expandMatch : Match -> String
expandMatch { submatches } =
  case (List.head submatches, List.tail submatches) of
    (Just (Just n), Just t) ->
      case String.toInt n of
        (Ok n) ->
          case List.head t of
            Just (Just c) -> String.repeat n c
            _ -> ""
        _ -> ""
    (_, _) -> ""

decode : String -> String
decode = replace All (regex "(\\d+)(.)") expandMatch


version : Int
version =
  2