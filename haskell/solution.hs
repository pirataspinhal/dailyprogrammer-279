import Data.List.Utils -- cabal install missingH

-- solution.hs
--      reflow and justify input text to 40-char width.
--      redir the output to a formatting function, so
--      results can actually be seen. e.g.:
--      putStrLn(prettify "sample text")

-- solution entry point
prettify :: [Char] -> [Char]
prettify [] = []
prettify a = concat(justify(reflow(words a)))

-- reflow word list function
reflow:: [[Char]] -> [[Char]]
reflow a@(_:[]) = a
reflow a@(x:y:_)
  | length(x ++ " " ++ y) <= 40 = reflow((x ++ " " ++ y):tail(tail a))
  | otherwise = (x ++ "\n"):[] ++ reflow(tail a)

-- justify line list function
justify :: [[Char]] -> [[Char]]
justify a@(_:[]) = a
justify a@(x:_)
  | ((countElem ' ' x) + (length x) <= 40)
  = justify((replace " " "  " x):(tail a))
  | otherwise = x:[] ++ justify(tail a)
