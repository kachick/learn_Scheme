(define (larger x y)
  (cond ((> x y) x)
    (else y)))

; example
(print (larger 1 2))
(print (larger 2 1))
(print (larger -2 1))