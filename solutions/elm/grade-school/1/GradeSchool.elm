module GradeSchool exposing (..)

import Debug exposing (log)
import Set


type alias Roster =
    List ( Int, String )


empty : Roster
empty =
    []


addStudent : Int -> String -> Roster -> Roster
addStudent grade name roster =
    roster ++ [ ( grade, name ) ]


inGrade : Int -> ( Int, String ) -> Bool
inGrade targetGrade ( grade, _ ) =
    targetGrade == grade


studentsInGrade : Int -> Roster -> List String
studentsInGrade grade roster =
    List.filter (inGrade grade) roster
        |> List.map Tuple.second
        |> List.sort



-- doAllStudents : Roster -> List ( Int, List String ) -> List ( Int, List String )
-- doAllStudents roster results =
--   if List.isEmpty roster then
--     results
--   else
--


allStudents : Roster -> List ( Int, List String )
allStudents roster =
    let
        grades =
            List.map Tuple.first roster
                |> Set.fromList
                |> Set.toList
                |> List.sort
    in
        List.map (\grade -> ( grade, studentsInGrade grade roster )) grades



-- doAllStudents roster []