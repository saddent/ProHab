-- Pattern Matching
len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len(xs)

-- Pattern Matching
halve :: [a] -> ([a], [a])
halve [] = ([], [])
halve [x] = ([x], [])
halve xs = (take midl xs , drop midl xs)
        where midl = div (len xs) 2

-- Pattern Matching
third :: [a] -> a
third xs = head(tail(tail(xs)))

{-- 
Other definitions
third xs = xs !! 2
third (x:y:z:xs) = z
third xs = head(tail(tail(xs)))
third (x:xs) = head(drop 1 xs)
--}

(||) :: Bool -> Bool -> Bool
False   ||    False = False
_       ||    _     = True

{- (&&) :: Bool -> Bool -> Bool
True    &&      True    =   True
_       &&      _       =   False
 -}

{- (&&) :: Bool -> Bool -> Bool
a && b = if a == True then 
    if b == True then True else False 
    else False
 -}

(&&) :: Bool -> Bool -> Bool
a && b = if a == True then 
    b else False


-- Pattern Matching
safetail :: [a] -> [a]
safetail [] = []
safetail xs = tail xs

{- 
--Conditional Expression
safetail :: [a] -> [a]
safetail xs = if null (tail xs)
            then [] else tail xs
 -}

{-
-- guarded equations
safetail :: [a] -> [a]
safetail xs
    | null (tail xs) = []
    | otherwise = tail xs
 -}


mult :: Int -> Int-> Int -> Int
mult = \x -> (\y -> \z -> (x*y*z))

luhndouble :: Int -> Int
luhndouble a
    | (2*a) > 9 = (2*a)-9
    | otherwise = a*2

luhn :: Int -> Int -> Int -> Int -> Bool
luhn a b c d =  mod (luhnsum a b c d) 10 == 0
                where luhnsum = \a -> (\b -> (\c -> (\d -> (luhndouble a + b + luhndouble c + d)))) 

main = print(halve[1, 2, 3, 4, 5])