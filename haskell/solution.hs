import Data.List

-- solution.hs
--      reflow and justify input text to 40-char width.
--      redir the output to a formatting function, so
--      results can actually be seen. e.g.:
--      putStrLn(prettify "sample text")

-- curryfying function
prettify :: [Char] -> [Char]
prettify [] = []
prettify a = concat(justify(reflow a))

-- reflow entry function
reflow :: [Char] -> [[Char]]
reflow [] = []
reflow a =
        let (b, c) = reflow'(take 41 a)
        in b:reflow(c ++ (drop 41 a))

-- reflow "tokenizer" function
reflow' :: [Char] -> ([Char], [Char])
reflow' [] = ([], [])
reflow' a
        | length a <= 40 = (a, [])
        -- also swap last char of 'c' for '\n'
        | otherwise = (init(reverse c) ++ "\n", reverse b)
          where (b, c) = span(/= ' ')(reverse a)

-- justify line list function
justify :: [[Char]] -> [[Char]]
justify a@(x:[]) = a
justify a@(x:y:_)
        -- if justified line is SEQ to previous, then commit action
        | length(findIndices(== ' ') y) + (length y) <= length x
        = justify(x:concat(map justify' y):tail(tail a))
        | otherwise = x:justify(tail a)

-- justify map function
justify' :: Char -> [Char]
justify' ' ' = "  "
justify' c = c:[]
