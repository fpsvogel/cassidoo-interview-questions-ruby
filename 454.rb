# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-454
# TODO
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

def min_repairs(grid, k)
  repairs = 0

  loop do
    zeros = find_zeros(grid)
    adjacent_zeros = zeros.map { |(row_i, col_i)|
      above = grid.dig(row_i - 1, col_i) if row_i > 0
      left = grid.dig(row_i, col_i - 1) if col_i > 0
      below = grid.dig(row_i + 1, col_i) if row_i < grid.size - 1
      right = grid.dig(row_i, col_i + 1) if col_i < grid[0].size - 1
      above_left = grid.dig(row_i - 1, col_i - 1) if row_i > 0 && col_i > 0
      below_left = grid.dig(row_i + 1, col_i - 1) if row_i < grid.size - 1 && col_i > 0
      below_right = grid.dig(row_i + 1, col_i + 1) if row_i < grid.size - 1 && col_i < grid[0].size - 1
      above_right = grid.dig(row_i - 1, col_i + 1) if row_i > 0 && col_i < grid[0].size - 1

      # if this zero is "blocking" (in the path of two others) then count it as highest priority
      next 4 if (above == 0 && below == 0 && [left, above_left, below_left].include?(1) && [right, above_right, below_right].include?(1)) ||
        (left == 0 && right == 0 && [above, above_left, above_right].include?(1) && [below, below_left, below_right].include?(1))

      # otherwise, count priority as the number of adjacent zeros
      [above, left, below, right].count(0)
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
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
]
k_3 = 6

grid_4 = [
  [0, 0, 0],
  [0, 0, 0],
  [1, 0, 1],
  [0, 0, 0],
  [0, 0, 0]
]
k_4 = 6

raise unless min_repairs(grid_1, k_1) == 2
raise unless min_repairs(grid_2, k_2) == 3
raise unless min_repairs(grid_3, k_3) == 4
raise unless min_repairs(grid_4, k_4) == 1
puts "✓ Tests passed"
