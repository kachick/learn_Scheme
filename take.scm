; example
(print (take `(2 1 3) 0)) ;()
(print (take `(2 1 3) 1)) ;(2)
(print (take `(2 1 3) 2)) ;(2 1)
(print (take `(2 1 3) 3)) ;(2 1 3)
(print (take `(2 1 3) 4)) ; gosh: "error": take: input list is too short (expected at least 4 elements, butonly 3 elements long): (2 1 3)