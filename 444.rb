# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-444
# https://web.archive.org/web/20260224024309/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-444/124
#
# Instructions:
#
# You have a 2D grid of numbers. Write a function that zooms in by an integer
# factor k >= 2 by turning each cell into a k x k block with the same value,
# returning the bigger grid.
#
# Examples: see tests below.
#
# Source:
# https://buttondown.com/cassidoo/archive/imaginary-obstacles-are-insurmountable-real-ones/

def zoom(grid, factor)
  grid
    .map { |row|
      row.flat_map { |col| [col] * factor } # zoom on x axis
    }
    .flat_map { |row| [row] * factor } # zoom on y axis
end

# Tests

zoom([[1, 2], [3, 4]], 2).then do
  p it
  raise unless it ==
    [
      [1, 1, 2, 2],
      [1, 1, 2, 2],
      [3, 3, 4, 4],
      [3, 3, 4, 4]
    ]
end

zoom([[7, 8, 9]], 3).then do
  p it
  raise unless it ==
    [
      [7, 7, 7, 8, 8, 8, 9, 9, 9],
      [7, 7, 7, 8, 8, 8, 9, 9, 9],
      [7, 7, 7, 8, 8, 8, 9, 9, 9]
    ]
end

zoom([[1], [2]], 3).then do
  p it
  raise unless it ==
    [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
      [2, 2, 2],
      [2, 2, 2],
      [2, 2, 2]
    ]
end
