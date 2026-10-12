module RobotSimulator exposing (..)


type Bearing
    = North
    | East
    | West
    | South


type alias Point =
    { x : Int, y : Int }


type alias Robot =
    { bearing : Bearing
    , coordinates : Point
    }


defaultRobot =
    Robot North { x = 0, y = 0 }


turnRight : Robot -> Robot
turnRight r =
    let
        nextBearing =
            case r.bearing of
                North ->
                    East

                East ->
                    South

                South ->
                    West

                West ->
                    North
    in
        { r | bearing = nextBearing }


turnLeft : Robot -> Robot
turnLeft r =
    let
        nextBearing =
            case r.bearing of
                North ->
                    West

                West ->
                    South

                South ->
                    East

                East ->
                    North
    in
        { r | bearing = nextBearing }


advance : Robot -> Robot
advance robot =
    let
        r =
            robot.coordinates

        coords =
            case robot.bearing of
                North ->
                    { x = r.x, y = r.y + 1 }

                East ->
                    { y = r.y, x = r.x + 1 }

                South ->
                    { x = r.x, y = r.y - 1 }

                West ->
                    { y = r.y, x = r.x - 1 }
    in
        Robot robot.bearing coords


simulate : String -> Robot -> Robot
simulate prog robot =
    if String.isEmpty prog then
        robot
    else
        let
            nextbot =
                case String.left 1 prog of
                    "L" ->
                        turnLeft robot

                    "R" ->
                        turnRight robot

                    "A" ->
                        advance robot

                    _ ->
                        robot
        in
            simulate (String.dropLeft 1 prog) nextbot