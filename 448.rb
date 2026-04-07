# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-448
# https://web.archive.org/web/20260402172251/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-448/198
#
# Instructions:
#
# You're given a 2D grid representing a city where each cell is either empty
# (0), a fire station (1), or a building (2). Fire stations can serve buildings
# based on horizontal + vertical moves only. Return a 2D grid where each cell
# shows the minimum distance to the nearest fire station.
#
# Examples:
#
#     fireStationCoverage([
#       [2, 0, 1],
#       [0, 2, 0],
#       [1, 0, 2]
#     ])
#     > [[2, 1, 0],
#        [1, 2, 1],
#        [0, 1, 2]]
#
#     fireStationCoverage([
#       [1, 0, 0, 1],
#       [0, 0, 0, 0],
#       [0, 0, 0, 0],
#       [1, 0, 0, 1]
#     ])
#     > [[0, 1, 1, 0],
#        [1, 2, 2, 1],
#        [1, 2, 2, 1],
#        [0, 1, 1, 0]]
#
# Source:
# https://buttondown.com/cassidoo/archive/u1faaa-your-work-feels-different-when-its-made/

def fire_station_coverage(grid)
  fire_station_coordinates = []
  grid.each.with_index do |cols, row_i|
    cols.each.with_index do |col, col_i|
      fire_station_coordinates << [row_i, col_i] if col == 1
    end
  end

  grid.map.with_index { |cols, row_i|
    cols.map.with_index { |col, col_i|
      fire_station_coordinates.map { |station_row_i, station_col_i|
        (station_row_i - row_i).abs + (station_col_i - col_i).abs
      }.min
    }
  }
end

# Tests

raise unless fire_station_coverage([
  [2, 0, 1],
  [0, 2, 0],
  [1, 0, 2]
]) == [
  [2, 1, 0],
  [1, 2, 1],
  [0, 1, 2]
]

raise unless fire_station_coverage([
  [1, 0, 0, 1],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [1, 0, 0, 1]
]) == [
  [0, 1, 1, 0],
  [1, 2, 2, 1],
  [1, 2, 2, 1],
  [0, 1, 1, 0]
]

puts "✓ Tests passed"
