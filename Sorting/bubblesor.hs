min:: Int->Int->Int
| a <= b = a
| _, _ = b

findmin :: [Int] -> Int
findmin = 
    | [] = 0
    | (x:xs) = min x, findmin(xs)

bubblesort :: [Int] -> [Int]
bubblesort = 
    | [] = []
    | (xs) =
        bubblesort(take(findmin(xs), xs) ++ drop(findmin(xs), xs))

main = print(bubblesort[4,3,2,1])