# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-447
# https://web.archive.org/web/20260316145350/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-447/189
#
# Instructions:
#
# Given a string s consisting only of 'a' and 'b', you may swap adjacent
# characters any number of times. Return the minimum number of adjacent swaps
# needed to transform s into an alternating string, either "ababab..." or
# "bababa...", or return -1 if it's impossible.
#
# Examples:
#
#     minSwapsToAlternate('aabb')
#     1
#
#     minSwapsToAlternate('aaab')
#     -1
#
#     minSwapsToAlternate('aaaabbbb')
#     6
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f312-dont-let-anyone-rob-you-of-your/

# Based on the solution by lpogic at
# https://web.archive.org/web/20260316145350/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-447/189#post_4
def min_swaps_to_alternate(str)
  ["ab", "ba"].filter_map { swaps_to_pattern(str, it) }.min || -1
end

def swaps_to_pattern(str, pattern)
  cache = Hash.new(-1)

  (0...str.size).sum { |index|
    char = pattern[index % pattern.size]
    match_index = str.index(char, cache[char] + 1)
    return nil unless match_index
    cache[char] = match_index
    [match_index - index, 0].max
  }
end

# Tests

raise unless min_swaps_to_alternate("aabb") == 1
raise unless min_swaps_to_alternate("aaab") == -1
raise unless min_swaps_to_alternate("aaaabbbb") == 6
puts "✓ Tests passed"
