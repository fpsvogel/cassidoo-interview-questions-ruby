# Other solutions:
# TODO
#
# Instructions:
#
# Given an array of positive integers, find the length of the longest
# subsequence where every adjacent pair of elements in the subsequence is
# coprime (where the greatest common divisor, or GCD, is 1).
#
# Examples:
#
#     longestCoprimeSubsequence([6, 12, 4, 8])
#     > 1 // none are coprime
#
#     longestCoprimeSubsequence([4, 3, 6, 9, 7, 2])
#     > 4 // [4, 3, 7, 2], where gcd(4,3)=1, gcd(3,7)=1, gcd(7,2)=1
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f57a-there-is-power-in-being-robbed-still/

def longest_coprime_subsequence(numbers)
  (1..numbers.length - 1).reverse_each do |length|
    numbers.combination(length) do |subsequence|
      return subsequence.length if subsequence
        .flat_map { |n| divisors(n) }
        .tally
        .none? { |n, count| n != 1 && count > 1 }
    end
  end
end

# From https://stackoverflow.com/a/72449326
# I also tried with the Prime gem: https://stackoverflow.com/a/56352354
# but with large inputs it is slower than this approach.
def divisors(n)
  (1..Math.sqrt(n)).each_with_object([]) { |i, arr|
    (n % i).zero? && arr << i && n / i != i && arr << n / i
  }
end

# Tests

raise unless longest_coprime_subsequence([6, 12, 4, 8]) == 1
# [4, 3, 7]; the result of the second example in the description is incorrect
raise unless longest_coprime_subsequence([4, 3, 6, 9, 7, 2]) == 3
puts "✓ Tests passed"
