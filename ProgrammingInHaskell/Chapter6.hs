import Prelude hiding ((^), length, drop, and, init, concat, replicate, (!!), elem, take)

fact :: Int -> Int
fact 0 = 1
fact n 
    | n > 0 = n * (fact (n-1))


sumdown :: Int -> Int
sumdown 0 = 0
sumdown n
    | n > 0 = n + (sumdown (n-1))

(^) :: Int -> Int -> Int
a ^ 0 = 1
a ^ b = a * (a ^ (b-1))

euclid :: Int -> Int -> Int
euclid a 0 = a
euclid a b
    | b < a = euclid (a-b) b
    | otherwise = euclid (b-a) a

length :: [a] -> Int
length [] = 0
length (x:xs) = 1 + length xs

drop :: Int -> [a] -> [a]
drop _ [] = []
drop 0 xs = xs
drop d (x:xs) = drop (d-1) xs

take :: Int -> [a] -> [a]
take _ [] = []
take 0 xs = []
take d (x:xs) = x : take (d-1) xs

init :: [a] -> [a]
init [a] = []
init (x:xs) = x : init(xs)

and :: [Bool] -> Bool
and [] = True
and (x:xs) 
    | x == False = False
    | otherwise = x && (and xs)

concat :: [[a]] -> [a]
concat [] = []
concat [[a]] = [a]
concat (x:xs) = x ++ (concat xs)

replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n a = (a : replicate (n-1) a)

(!!) :: [a] -> Int -> a
(x:xs) !! 0 = x
(x:xs) !! n = xs !! (n-1)

elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem v (x:xs)
    | v == x = True
    | otherwise = elem v xs

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x <= y = x : merge (xs) (y:ys)
    | otherwise = y : merge (x:xs) (ys)

halve :: [a] -> ([a], [a])
halve [] = ([], []) 
halve [a] = ([a], [])
halve xs = (first, second)
            where
                first = take mid xs
                second = drop mid xs
                mid = div (length xs) 2

msort :: Ord a => [a] -> [a]
msort [] = []
msort [a] = [a]
msort xs = merge (msort low) (msort high)
                where (low, high) = halve xs