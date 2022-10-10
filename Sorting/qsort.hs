qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
                where
                    smaller = [a | a<-xs, a <= x]
                    larger = [b | b<-xs, b > x]

main = print(qsort[3, 2, 1])