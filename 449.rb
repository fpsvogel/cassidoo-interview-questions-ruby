# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-449
# https://web.archive.org/web/20260402172834/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-449/213
#
# Instructions:
#
# Given a text string and a pattern, implement a fuzzy string search using the
# Bitap algorithm (https://en.wikipedia.org/wiki/Bitap_algorithm) that finds all
# positions in the text where the pattern matches with at most k errors
# (insertions, deletions, or substitutions). Return an array of objects
# containing the position and the number of errors at that match.
#
# Examples:
#
#     > fuzzySearch("the cat sat on the mat", "cat", 0);
#     > [{ position: 4, errors: 0 }]
#
#     > fuzzySearch("cassidoo", "cool", 1);
#     > []
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f6cb-ufe0f-set-realistic-goals-keep-re/

# Based on the solution by lpogic at
# https://web.archive.org/web/20260402172834/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-449/213#post_2
# Difference: memoization is added here, for linear rather than exponential time.
def min_error(haystack, haystack_left, needle, needle_left, memo)
  return 0 if needle_left <= 0
  return needle_left if haystack_left <= 0
  return memo[[haystack_left, needle_left]] if memo.key?([haystack_left, needle_left])

  substitution_error = min_error(haystack, haystack_left - 1, needle, needle_left - 1, memo)
  memo[[haystack_left, needle_left]] =
    if haystack[-haystack_left] == needle[-needle_left]
      substitution_error
    else
      1 + [
        min_error(haystack, haystack_left, needle, needle_left - 1, memo),
        min_error(haystack, haystack_left - 1, needle, needle_left, memo),
        substitution_error
      ].min
    end
end

def fuzzy_search(haystack, needle, max_error)
  (0...haystack.size).filter_map do |i|
    error = min_error(haystack, haystack.size - i, needle, needle.size, {})
    {position: i, errors: error} if error <= max_error
  end
end

# Tests

fuzzy_search("the cat sat on the mat", "cat", 0).then do
  p it
  raise unless it == [{position: 4, errors: 0}]
end

fuzzy_search("cassidoo", "cool", 1).then do
  p it
  raise unless it == []
end

fuzzy_search("cassidoo", "cool", 3).then do
  p it
  raise unless it == [{position: 0, errors: 3}, {position: 4, errors: 3}, {position: 5, errors: 2}, {position: 6, errors: 2}, {position: 7, errors: 3}]
end
