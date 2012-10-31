(load "./atom?")

(print (atom? (quote atom))) ;#t
(print (atom? (quote turkey))) ;#t
(print (atom? (quote 1492))) ;#t
(print (atom? (quote u))) ;#t
(print (atom? (quote *abc$))) ;#t

(print (atom? (quote (atom)))) ;#f
(print (atom? (quote (atom turkey or)))) ;#f

