# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-450
# TODO
#
# Instructions:
#
# Given an integer n, return all unique combinations of Perrin numbers
# (https://en.wikipedia.org/wiki/Perrin_number) (up to and including the nth
# Perrin number) that sum to a target value k, where each Perrin number can be
# used at most once. Return the combinations sorted in ascending order.
#
# Examples:
#
#     > perrinCombinations(7, 12)
#     [[0,2,3,7],[0,5,7],[2,3,7],[5,7]]
#
#     > perrinCombinations(6, 5)
#     [[0,2,3],[0,5],[2,3],[5]]
#
# Source:
# https://buttondown.com/cassidoo/archive/9-ufe0f-u20e3-there-are-no-mistakes-only/

def perrin_combinations(n, k)
  numbers = (0..n).map { perrin_number(it) }

  (1..numbers.count).flat_map { |count|
    numbers.combination(count).map(&:uniq).map(&:sort).select { |combo| combo.sum == k }
  }.uniq.sort
end

def perrin_number(n)
  case n
  when ...0 then raise("n cannot be negative")
  when 0 then 3
  when 1 then 0
  when 2 then 2
  else perrin_number(n - 2) + perrin_number(n - 3)
  end
end

# Tests

raise unless perrin_combinations(7, 12) == [[0, 2, 3, 7], [0, 5, 7], [2, 3, 7], [5, 7]]
raise unless perrin_combinations(6, 5) == [[0, 2, 3], [0, 5], [2, 3], [5]]
puts "✓ Tests passed"
