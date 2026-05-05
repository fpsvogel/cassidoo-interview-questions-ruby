# Other solutions:
# https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-452
#   https://web.archive.org/web/20260422112954/https://www.rubyforum.org/t/cassidoo-s-interview-question-of-the-week-452/266
#
# Instructions:
#
# You're building a pizza ordering system that enforces strict ingredient
# layering rules. Given an array of pizza layers (bottom to top) and a set of
# rules where each rule states that ingredient A must appear somewhere below
# ingredient B, write a function that determines whether the pizza is valid. If
# any rule is violated, return the pair [A, B] that was violated first (in the
# order the rules are given). If the pizza is valid, return true.
#
# Examples:
#
#     const layers = ["dough", "sauce", "cheese", "pepperoni", "basil"];
#     const rules = [
#       ["sauce", "cheese"],
#       ["cheese", "pepperoni"],
#       ["dough", "basil"],
#     ];
#     const rules2 = [
#       ["cheese", "pepperoni"],
#       ["cheese", "sauce"], // "it's under the sauce"
#     ];
#
#     validatePizza(layers, rules);
#     > true
#
#     validatePizza(layers, rules2);
#     > ['cheese', 'sauce']
#
# Source:
# https://buttondown.com/cassidoo/archive/u1f9d1-u1f680-we-will-always-choose-earth-we-will/

def validate_pizza(layers, rules)
  invalidated_rule = rules.find { |ingredient_a, ingredient_b|
    layers.index(ingredient_a) > layers.index(ingredient_b)
  }

  invalidated_rule || true
end

# Tests

layers = ["dough", "sauce", "cheese", "pepperoni", "basil"]
rules = [
  ["sauce", "cheese"],
  ["cheese", "pepperoni"],
  ["dough", "basil"]
]
rules2 = [
  ["cheese", "pepperoni"],
  ["cheese", "sauce"]
]

raise unless validate_pizza(layers, rules) == true
raise unless validate_pizza(layers, rules2) == ["cheese", "sauce"]
puts "✓ Tests passed"
