# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-453
# TODO
#
# Instructions:
#
# Given a string s containing letters and ? wildcards (that can match any
# letter), and a target pattern string pattern, rearrange the entire string
# however you like. Return the maximum number of non-overlapping copies of
# pattern that can appear in the rearranged result.
#
# Examples:
#
#     maxPatternCopies("abcabc???", "ac")  // 3
#
#     maxPatternCopies("aab??", "aab")  // 1
#
#     maxPatternCopies("??????", "abc")  // 2
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f9f0-after-all-is-said-and-done-more-is-said/

def max_pattern_copies(string, pattern)
  wildcards = string.count("?")
  string_char_counts = string.chars.tally.except("?")
  pattern_char_counts = pattern.chars.tally
  max_matches = string.length / pattern.length

  (0..max_matches).reverse_each.find do |candidate_match_count|
    wildcards_needed = pattern_char_counts.sum { |pattern_char, pattern_char_count|
      actual_occurrences_in_string = string_char_counts[pattern_char] || 0
      needed_occurrences_for_match_count = candidate_match_count * pattern_char_count
      [0, needed_occurrences_for_match_count - actual_occurrences_in_string].max
    }
    wildcards_needed <= wildcards
  end
end

# Tests

raise unless max_pattern_copies("abcabc???", "ac") == 3
raise unless max_pattern_copies("aab??", "aab") == 1
raise unless max_pattern_copies("??????", "abc") == 2
puts "✓ Tests passed"
