# Other solutions:
# https://web.archive.org/web/20260416150023/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-451/231
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
  perrin_numbers(n)
    .uniq
    .sort
    .then { sum_combinations(it, k) }
    .sort
end

def perrin_numbers(n)
  raise("n cannot be negative") if n.negative?

  numbers = [3, 0, 2]
  (3..n).each do |i|
    numbers << numbers[i - 2] + numbers[i - 3]
  end

  numbers[0..n]
end

def sum_combinations(numbers, k_remaining, current = [])
  return [current] if k_remaining.zero?

  numbers
    .take_while { it <= k_remaining }
    .flat_map.with_index { |num, i|
      sum_combinations(numbers[i + 1..], k_remaining - num, current + [num])
    }
end

# Tests

raise unless perrin_combinations(7, 12) == [[0, 2, 3, 7], [0, 5, 7], [2, 3, 7], [5, 7]]
raise unless perrin_combinations(6, 5) == [[0, 2, 3], [0, 5], [2, 3], [5]]
puts "✓ Tests passed"
