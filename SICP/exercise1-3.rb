$VERBOSE = true

def sum_of_square_from_two_largers_in_three_numbers(x, y, z)
  [x, y, z].sort_by{|n|-n}.take(2).inject(0){|sum, n|sum + (n ** 2)}
end

p sum_of_square_from_two_largers_in_three_numbers(3, 2, 5) #=> 34
p sum_of_square_from_two_largers_in_three_numbers(3, 5, 2) #=> 34