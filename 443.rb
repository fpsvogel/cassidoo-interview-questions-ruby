# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-443
#
# Instructions:
#
# Given an integer array and a number n, move all of the ns to the end of the
# array while maintaining the relative order of the non-ns. Bonus: do this
# without making a copy of the array!
#
# Examples:
#
#     moveNums([0,2,0,3,10], 0)
#     > [2,3,10,0,0]
#
# Source:
# https://buttondown.com/cassidoo/archive/everyone-deserves-the-space-to-change-and-for/

def flat_reverse_partition(array, el)
  array.sort_by { (it == el) ? 1 : 0 }
end

def flat_reverse_partition!(array, el)
  array.sort_by! { (it == el) ? 1 : 0 }
end

# Tests

flat_reverse_partition([0, 2, 0, 3, 10], 0).then do
  p it
  raise unless it == [2, 3, 10, 0, 0]
end

[0, 2, 0, 3, 10].then do
  flat_reverse_partition!(it, 0)
  p it
  raise unless it == [2, 3, 10, 0, 0]
end
