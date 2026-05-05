# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-454
#   https://web.archive.org/save/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-454/297
# https://codingkata.tardate.com/ruby/min-repairs
#   https://web.archive.org/web/20260505182612/https://codingkata.tardate.com/ruby/min-repairs
#
# Instructions:
#
# You are given a 2D grid where 1 represents an intact tile and 0 represents a
# broken tile. A "broken region" is a group of connected 0s (connected
# horizontally or vertically). Find the minimum number of tiles you need to
# repair to ensure no broken region has an area larger than k.
#
# Examples:
#
#     const grid = [
#       [1, 0, 0, 1],
#       [1, 0, 0, 1],
#       [1, 1, 0, 1],
#       [0, 1, 1, 1],
#     ];
#     const k = 2;
#
#     let newGrid = [
#       [1, 0, 0, 1],
#       [1, 0, 0, 1],
#       [1, 1, 0, 1],
#       [0, 0, 1, 1],
#     ];
#     let newK = 1;
#
#     minRepairs(grid, k)
#     > 2
#
#     minRepairs(newGrid, newK)
#     > 3
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f57a-there-is-power-in-being-robbed-still/

# This is an incomplete solution; tests for the examples given above pass, but
# not more complicated examples that I came up with.
def min_repairs(grid, k)
  repairs = 0

  loop do
    zeros = find_zeros(grid)
    adjacent_zeros = zeros.map { |(row_i, col_i)|
      [
        (grid.dig(row_i - 1, col_i) if row_i > 0),
        (grid.dig(row_i, col_i - 1) if col_i > 0),
        (grid.dig(row_i + 1, col_i) if row_i < grid.size - 1),
        (grid.dig(row_i, col_i + 1) if col_i < grid[0].size - 1)
      ].count(0)
    }
    max_adjacent_zeros = adjacent_zeros.max
    max_adjacent_zeros_indices = adjacent_zeros.each_index.select { adjacent_zeros[it] == max_adjacent_zeros }
    zeros_change_candidates = max_adjacent_zeros_indices.map { zeros[it] }
    repairs += 1

    zero_to_change = zeros_change_candidates.min_by { |zero_change_candidate|
      candidate_zeros = zeros.dup
      candidate_zeros.delete(zero_change_candidate)

      contiguous_zero_regions = []
      loop do
        break if candidate_zeros.empty?
        contiguous_region = contiguous_from!(*candidate_zeros.pop, candidate_zeros)
        contiguous_zero_regions << contiguous_region
      end

      largest_contiguous_zero_region = contiguous_zero_regions.map(&:count).max
      return repairs if largest_contiguous_zero_region <= k
      largest_contiguous_zero_region
    }

    grid[zero_to_change[0]][zero_to_change[1]] = 1
  end
end

def find_zeros(grid)
  grid.flat_map.with_index { |row, row_i|
    row.filter_map.with_index { |col, col_i|
      [row_i, col_i] if col.zero?
    }
  }
end

# note: mutates `zeros` by deleting the returned contiguous region from it
def contiguous_from!(row_i, col_i, zeros)
  above = [row_i - 1, col_i]
  left = [row_i, col_i - 1]
  below = [row_i + 1, col_i]
  right = [row_i, col_i + 1]

  immediate_contiguous = [above, left, below, right] & zeros
  immediate_contiguous.each do
    zeros.delete(it)
  end
  [[row_i, col_i], *immediate_contiguous.flat_map { contiguous_from!(_1, _2, zeros) }]
end

# Tests

grid_1 = [
  [1, 0, 0, 1],
  [1, 0, 0, 1],
  [1, 1, 0, 1],
  [0, 1, 1, 1]
]
k_1 = 2

grid_2 = [
  [1, 0, 0, 1],
  [1, 0, 0, 1],
  [1, 1, 0, 1],
  [0, 0, 1, 1]
]
k_2 = 1

grid_3 = [
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0]
]
k_3 = 15

grid_4 = [
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0]
]
k_4 = 12

grid_5 = [
  [0, 0, 0],
  [0, 0, 0],
  [1, 0, 1],
  [0, 0, 0],
  [0, 0, 0]
]
k_5 = 6

raise unless min_repairs(grid_1, k_1) == 2
raise unless min_repairs(grid_2, k_2) == 3
raise unless min_repairs(grid_3, k_3) == 6 # failing
raise unless min_repairs(grid_4, k_4) == 6 # failing
raise unless min_repairs(grid_5, k_5) == 1 # failing
puts "✓ Tests passed"
