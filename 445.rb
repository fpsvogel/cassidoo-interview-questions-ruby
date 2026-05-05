# Other solutions:
# https://web.archive.org/web/20260303091438/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-445/151
#
# Instructions:
#
# Given an array of integers, find the contiguous subarray that has the largest
# sum and return that sum. A subarray must contain at least one element. If all
# elements are negative, return the largest (least negative) value. If you need
# a hint, look up Kadane's Algorithm!
#
# Examples:
#
#     maxSubarraySum([-2, 1, -3, 4, -1, 2, 1, -5, 4])
#     > 6
#     maxSubarraySum([5])
#     > 5
#     maxSubarraySum([-1, -2, -3, -4])
#     > -1
#     maxSubarraySum([5, 4, -1, 7, 8])
#     > 23
#
# Source:
# https://buttondown.com/cassidoo/archive/change-but-start-slowly-because-direction-is-more/

# O(n^3) using brute force
def max_subarray_sum(numbers)
  numbers.length.downto(1).map { |sublength|
    numbers.each_cons(sublength).map(&:sum).max
  }.max
end

# O(n) using Kadane's Algorithm
def max_subarray_sum_kadane(numbers)
  running_total = max_sum = numbers.first

  numbers[1..].each do |n|
    running_total = [n, running_total + n].max
    max_sum = [max_sum, running_total].max
  end

  max_sum
end

# Tests

raise unless max_subarray_sum([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
raise unless max_subarray_sum([5]) == 5
raise unless max_subarray_sum([-1, -2, -3, -4]) == -1
raise unless max_subarray_sum([5, 4, -1, 7, 8]) == 23
puts "✓ Tests passed"
