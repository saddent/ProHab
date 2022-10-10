import Data.Char
-- Examples for List Comprehension
-- Find all the factors of the number
factors :: Int -> [Int]
factors n = [x | x <- [1..n], mod n x == 0]

-- Check if a number is a prime
prime :: Int -> Bool
prime n = factors n == [1,n]

-- List of primes
primes :: Int -> [Int]
primes n = [x | x <- [1..n], prime x == True]

-- return a list of associated values in a given set of key-value pairs
find :: Eq a => a -> [(a,b)] -> [b]
find k t = [v | (k', v) <- t, k == k']

-- returns a list of pairs of adjacent elements
adjpairs :: [a] -> [(a,a)]
adjpairs xs = zip xs (tail xs)

-- check sorted
sorted :: Ord a => [a] -> Bool
sorted xs = and [x <= y | (x, y) <- adjpairs xs]

-- find the indices of an element in the list
positions :: Eq a => [a] -> a -> [Int]
positions xs x = [i | (x' , i) <- zip xs [0..], x == x']

-- counts the occurrence of the charater in the string
count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x']

-- return #lowercase characters
lowers :: [Char] -> Int
lowers xs = length [x | x <- xs, x >= 'a' && x <= 'z']

-- Caesar Cipher
-- letter to integer
let2int :: Char -> Int
let2int c = ord c - ord 'a'

-- integer to letter
int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

shift :: Int -> Char -> Char
shift n c 
    | isLower c = int2let (mod (let2int c + n) 26)
    | otherwise = c

-- encode the string
encode :: Int -> String -> String
encode c xs = [shift c x | x <- xs]

table :: [Float]
table = [   8.1, 1.5, 2.8, 4.2, 12.7, 2.2, 2.0, 6.1, 7.0,
            0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0,
            6.3, 9.0, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1  ]

percent :: Int -> Int -> Float
percent n m = (fromIntegral n/ fromIntegral m) * 100

freqs :: String -> [Float]
freqs xs = [percent (count x xs) n | x <- ['a'..'z']]
            where n = lowers xs

chisqr :: [Float] -> [Float] -> Float
chisqr os es = sum [((o-e)^2)/e | (o,e) <- zip os es]

rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

crack :: String -> String
crack xs = encode (-factor) xs
    where 
        factor = head (positions chitab (minimum chitab))
        chitab = [chisqr (rotate n table') table | n <- [0..25]]
        table' = freqs xs
 

-- Exercises
--1
computesqrsum :: Int -> Int
computesqrsum n = sum [x*x | x <- [1..n]]

--2
grid :: Int -> Int -> [(Int, Int)]
grid m n = [(x, y) | x <- [0..m], y <- [0..n]]

--3
square :: Int -> [(Int, Int)]
square n = [(x, y) | x <- [0..n], y <- [0..n] ,x /= y]

--4
replicate :: Int -> a -> [a]
replicate n a = [a | x <- [1..n]]

--5
sqr :: Int -> Int
sqr n = n*n

pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x, y, z) | x <- [1..n], y <- [1..n], z <-[1..n], (sqr z) == ((sqr x) + (sqr y))]

--6
-- factors of a number without the number
pfactors :: Int -> [Int]
pfactors n = [x | x <- [1..(n-1)], (mod n x) == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (pfactors x) == x]

--7
-- scalar produce
scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [ x*y | (x, y) <- zip xs ys]
