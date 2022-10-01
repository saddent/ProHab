len :: [Int] -> Int
len [] = 0
len (x:xs) = 1 + len(xs)

halve :: [Int] -> ([Int], [Int])
halve [] = ([], [])
halve [x] = ([x], [])
halve xs = (take lhx xs, drop lhx xs)
            where lhx = div (len xs) 2 

mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort ls = merge (mergesort left) (mergesort right)
                where
                    (left, right) = halve ls

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y = x:merge xs (y:ys)
    | x > y  = y:merge (x:xs) (ys)

main = print(mergesort [10000000000000,-1, 2,5 ,6])