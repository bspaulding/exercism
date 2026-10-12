module SpaceAge exposing (..)

type Planet
  = Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Uranus
  | Neptune

period : Planet -> Float
period p =
  case p of
    Earth -> 31557600
    Mercury -> 0.2408467 * period Earth
    Venus -> 0.61519726 * period Earth
    Mars -> 1.8808158 * period Earth
    Jupiter -> 11.862615 * period Earth
    Saturn -> 29.447498 * period Earth
    Uranus -> 84.016846 * period Earth
    Neptune -> 164.79132 * period Earth

ageOn : Planet -> Float -> Float
ageOn p n = n / period p