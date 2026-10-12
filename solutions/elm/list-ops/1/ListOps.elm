module ListOps exposing (..)


lengthRecur : List a -> Int -> Int
lengthRecur xs l =
    case List.head xs of
        Nothing ->
            l

        Just h ->
            case List.tail xs of
                Nothing ->
                    l

                Just tail ->
                    lengthRecur tail (l + 1)


length : List a -> Int
length xs =
    lengthRecur xs 0


concat : List (List a) -> List a
concat xss =
    foldr (++) [] xss


append : List a -> List a -> List a
append xs ys =
    case ( List.head ys, List.tail ys ) of
        ( Nothing, _ ) ->
            xs

        ( Just head, Just tail ) ->
            append (xs ++ [ head ]) tail

        ( Just head, _ ) ->
            xs ++ [ head ]


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc xs =
    foldl f acc (reverse xs)


filterRecur : (a -> Bool) -> List a -> List a -> List a
filterRecur f xs ys =
    case ( List.head xs, List.tail xs ) of
        ( Nothing, _ ) ->
            ys

        ( Just head, Just tail ) ->
            if f head then
                filterRecur f tail (ys ++ [ head ])
            else
                filterRecur f tail ys

        ( Just head, _ ) ->
            if f head then
                ys ++ [ head ]
            else
                ys


filter : (a -> Bool) -> List a -> List a
filter f xs =
    filterRecur f xs []


mapRecur : (a -> b) -> List a -> List b -> List b
mapRecur f xs ys =
    case ( List.head xs, List.tail xs ) of
        ( Nothing, _ ) ->
            ys

        ( Just head, Just tail ) ->
            mapRecur f tail (ys ++ [ f head ])

        ( Just head, Nothing ) ->
            [ f head ]


map : (a -> b) -> List a -> List b
map f xs =
    mapRecur f xs []


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc xs =
    case ( List.head xs, List.tail xs ) of
        ( Nothing, _ ) ->
            acc

        ( Just head, Nothing ) ->
            f head acc

        ( Just head, Just tail ) ->
            foldl f (f head acc) tail


reverse : List a -> List a
reverse xs =
    case ( List.head xs, List.tail xs ) of
        ( Nothing, _ ) ->
            xs

        ( Just head, Just tail ) ->
            (reverse tail) ++ [ head ]

        ( Just head, Nothing ) ->
            [ head ]