# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-443
#   https://web.archive.org/web/20260217170635/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-443/98
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

module FlatReversePartition
  refine Enumerable do
    def flat_reverse_partition(el)
      sort_by { (it == el) ? 1 : 0 }
    end

    def flat_reverse_partition!(el)
      sort_by! { (it == el) ? 1 : 0 }
    end
  end
end

# Tests

using FlatReversePartition

raise unless [0, 2, 0, 3, 10].flat_reverse_partition(0) == [2, 3, 10, 0, 0]

[0, 2, 0, 3, 10].then do
  it.flat_reverse_partition!(0)
  raise unless it == [2, 3, 10, 0, 0]
end

puts "✓ Tests passed"
