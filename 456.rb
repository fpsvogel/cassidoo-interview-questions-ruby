# Other solutions:
# https://web.archive.org/web/20260521181408/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-456/335
#
# Instructions:
#
# You are given a 2D grid representing a screen, a starting position for a
# bouncing object, a target position, and an initial diagonal direction. On each
# step, the object moves one cell diagonally, and if its next move would leave
# the grid, it "bounces" by reversing the corresponding row and/or column
# direction before continuing. Return the number of bounces needed for the logo
# to land on the target cell, or -1 if it will loop forever without ever
# reaching it.
#
# Examples:
#
#     // inputs are grid, start, target, velocity/direction
#
#     countBouncesToTarget([8,8], [0,0], [3,4], [1,4])
#     > 2
#
#     countBouncesToTarget([3,3], [0,1], [2,1], [1,1])
#     > 1
#
#     countBouncesToTarget([4,5], [0,0], [3,3], [1,1])
#     > 0
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f929-competition-drives-innovation-but/

def count_bounces_to_target(grid, start, target, velocity)
  x, y = start
  dx, dy = velocity
  grid_x, grid_y = grid
  bounce_count = 0

  loop do
    x += dx
    until x.between?(0, grid_x - 1)
      x_bound = x.clamp(0, grid_x - 1)
      x = x_bound - (x - x_bound)
      dx = -dx
      bounce_count += 1
    end

    y += dy
    until y.between?(0, grid_y - 1)
      y_bound = y.clamp(0, grid_y - 1)
      y = y_bound - (y - y_bound)
      dy = -dy
      bounce_count += 1
    end

    return -1 if x == start[0] && y == start[1]
    return bounce_count if x == target[0] && y == target[1]
  end
end

# Tests

# the velocity of the first example in the description is incorrect
raise unless count_bounces_to_target([8, 8], [0, 0], [3, 4], [1, 6]) == 2
raise unless count_bounces_to_target([3, 3], [0, 1], [2, 1], [1, 1]) == 1
raise unless count_bounces_to_target([4, 5], [0, 0], [3, 3], [1, 1]) == 0
raise unless count_bounces_to_target([2, 2], [0, 0], [0, 1], [1, 1]) == -1
puts "✓ Tests passed"
