$VERBOSE = true

p [2, 1, 3, 4].sort{|x, y| x <=> y}   #=> [1, 2, 3, 4]
p [2, 1, 3, 4].sort{|x, y| -x <=> -y} #=> [4, 3, 2, 1]