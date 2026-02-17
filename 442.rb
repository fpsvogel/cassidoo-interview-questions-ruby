# Other solutions:
# https://www.rubyforum.org/t/cassidoos-interview-question-of-the-week-442
# https://web.archive.org/web/20260212143856/https://www.rubyforum.org/t/cassidoos-interview-question-of-the-week-442/86
#
# Instructions:
#
# February 2026 is a perfect month! Write a function that returns the closest
# previous and next perfect month around the given Gregorian year.
#
# Examples:
#
#     nearestPerfectMonths(2025)
#     > { prev: "2021-02", next: "2026-02" }
#
#     nearestPerfectMonths(2026)
#     > { prev: "2026-02", next: "2027-02" }
#
# Source:
# https://buttondown.com/cassidoo/archive/the-ability-to-observe-without-evaluating-is-the/

require "date"

def perfect_february?(year)
  return false if Date.leap?(year)

  february_1 = Date.new(year, 2, 1)
  february_1.sunday? || february_1.monday?
end

def nearest_perfect_months(year)
  prev_year = year.step(by: -1).find { perfect_february? it }
  next_year = (year + 1).step.find { perfect_february? it }

  {prev: "#{prev_year}-02", next: "#{next_year}-02"}
end

# Tests

nearest_perfect_months(2025).then do
  p it
  raise unless it == {prev: "2021-02", next: "2026-02"}
end

nearest_perfect_months(2026).then do
  p it
  raise unless it == {prev: "2026-02", next: "2027-02"}
end
