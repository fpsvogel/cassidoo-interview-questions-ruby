# Other solutions:
# TODO
#
# Instructions:
#
# Given a string s consisting of letters, convert each character to its opposite
# case that is, change every lowercase letter to uppercase, and every uppercase
# letter to lowercase. Bonus: add an "alternate" parameter that converts the
# whole string to AlTeRnAtE cAsE!
#
# Examples:
#
#     let alternating = true
#
#     toggleChar("Hello, world!")
#     > "hELLO, WORLD!"
#
#     toggleChar("HeheHeheHEheheHeH")
#     > "hEHEhEHEheHEHEhEh"
#
#     toggleChar("This will be alternated", alternating)
#     > "ThIs WiLl Be AlTeRnAtEd"
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f49c-technology-is-cool-but-youve-got-to-use-it/

def toggle_char(str, alternating: false)
  return alternating_case(str) if alternating

  str.swapcase
end

def alternating_case(str)
  upcase = false

  str.downcase.each_char.map { |char|
    next char unless char.match? /[[:alpha:]]/

    upcase = !upcase
    upcase ? char.upcase : char
  }.join
end

# Tests

# the velocity of the first example in the description is incorrect
raise unless toggle_char("Hello, world!") == "hELLO, WORLD!"
raise unless toggle_char("HeheHeheHEheheHeH") == "hEHEhEHEheHEHEhEh"
raise unless toggle_char("This will be alternated", alternating: true) == "ThIs WiLl Be AlTeRnAtEd"
raise unless toggle_char("åÅ") == "Åå"
puts "✓ Tests passed"
