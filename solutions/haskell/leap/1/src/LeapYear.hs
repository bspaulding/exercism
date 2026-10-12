module LeapYear (isLeapYear) where

divisibleBy :: Integer -> Integer -> Bool
divisibleBy x y = mod y x == 0

-- on every year that is evenly divisible by 4
--   except every year that is evenly divisible by 100
--     unless the year is also evenly divisible by 400
isLeapYear :: Integer -> Bool
isLeapYear year = divisibleBy 4 year && (not (divisibleBy 100 year) || divisibleBy 400 year)
