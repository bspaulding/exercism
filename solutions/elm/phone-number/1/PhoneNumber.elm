module PhoneNumber exposing (..)

import Char


getNumber : String -> Maybe String
getNumber s =
    let
        digits =
            String.filter Char.isDigit s

        l =
            String.length digits
    in
        if String.isEmpty digits then
            Nothing
        else if l == 11 && "1" == String.left 1 digits then
            Just (String.dropLeft 1 digits)
        else if l /= 10 then
            Nothing
        else
            Just digits


prettyPrint : String -> Maybe String
prettyPrint s =
    let
        digits =
            String.right 10 s

        area =
            String.concat [ "(", String.left 3 digits, ")" ]

        drop3 =
            String.dropLeft 3 digits

        seven =
            String.concat
                [ String.left 3 drop3
                , "-"
                , String.right 4 drop3
                ]

        pretty =
            String.join " " [ area, seven ]
    in
        Just pretty