(define (larger x y)
  (cond ((> x y) x)
    (else y)))

(define (square x) (* x x))

(define (sum-of-square-from-two-largers-in-three-numbers x y z)
  (+ (square (larger x y)) (square (larger y z))))

(define (sum-of-square-from-two-largers-in-three-numbers x y z)
  (cond (and (> x y) (> x z)) x))

  )

(print (sum-of-square-from-two-largers-in-three-numbers 3 2 5)) ;34
(print (sum-of-square-from-two-largers-in-three-numbers 3 5 2)) ;34