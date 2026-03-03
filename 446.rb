# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-446
# TODO archive.org link
#
# Instructions:
#
# Find the majority element in an array (one that appears more than n/2 times)
# in O(n) time and O(1) space without hashmaps. Hint: the Boyer-Moore Voting
# algorithm might help if you can't figure this one out!
#
# Examples:
#
#     > majorityElement([2, 2, 1, 1, 2, 2, 1, 2, 2])
#     2
#
#     > majorityElement([3, 3, 4, 2, 3, 3, 1])
#     3
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f6f5-the-way-to-right-wrongs-is-to-turn-the/

# Boyer-Moore voting algorithm
def majority_element(numbers)
  numbers
    .reduce([nil, 0]) { |(candidate, count), el|
      candidate = el if count.zero?
      [candidate, count + ((el == candidate) ? 1 : -1)]
    }
    .first
end

# Tests

majority_element([2, 2, 1, 1, 2, 2, 1, 2, 2]).then do
  p it
  raise unless it == 2
end

majority_element([3, 3, 4, 2, 3, 3, 1]).then do
  p it
  raise unless it == 3
end
