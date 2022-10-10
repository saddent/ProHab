fact :: Integer -> Integer
fact 0 = 1
fact n 
    | n > 0 = n * (fact (n-1))


sumdown :: Integer -> Integer
sumdown 0 = 0
sumdown n
    | n > 0 = n + (sumdown (n-1))
