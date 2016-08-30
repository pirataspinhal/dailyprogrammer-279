import Data.List.Utils -- cabal install missingH

-- output directly
reflow :: String -> IO()
reflow = putStrLn . concat . map (\x -> concat $ justify $ split_nt x) .
         allocate . words

-- split w/out trimming
split_nt ::  String  -> [String]
split_nt a = map (\x -> if endswith "\n" x then x else x ++ " ") $ split " " a

-- form lines from words
allocate :: [String] -> [String]
allocate [] = []
allocate a  = map (\x -> x ++ "\n") $ lines $
        (foldl1 (\acc xa -> if length xa + (length $ last $ lines acc) < 40
        then acc ++ " "  ++ xa
        else acc ++ "\n" ++ xa) a ++ "\n")

-- justify lines to 40c width
justify :: [String] -> [String]
justify a@(_:[]) = a
justify a@(x:_)
  | not(endswith "\n" x) && length(concat a) < 40
  = justify(tail a ++ (x ++ " "):[])
  | endswith "\n" x && length(concat a) >= 40
  = concat(tail a ++ x:[]):[]
  | otherwise = justify(tail a ++ x:[])
