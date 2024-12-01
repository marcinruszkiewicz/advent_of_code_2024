# AdventOfCode2024

Elixir solutions for the [2024 Advent of Code](https://adventofcode.com/2024) puzzles.

## Importing puzzle data

Puzzle data is generated on the AoC website. You need to grab your session cookie and put it into a `config/secrets.exs` file, after that you can run `mix input 1 2024` to get the inputs for day 1 of AoC 2024.

- `priv` directory - put your puzzle data here with proper name (`day_200.txt` etc)

## Solving a puzzle

- `test/examples` directory - put your example data here with a proper name (`day200.txt` etc)
- create an `AdventOfCode.Day200` module in `lib/advent_of_code/day_200.ex`. Needs to have a `part1` and an `part2` public methods, so that you can use the mix tasks to run them, otherwise it can use whatever you like.
- create a `tests/day200_test.exs` so that you can run tests: 

```assert Day200.part2("test/examples/day200.txt") == 12345```

## Running the puzzle solvers

Use the mix tasks. They both take the module name as an argument:

- `mix part1 Day200` solves the part one of the given puzzle using the `part1` method
- `mix part2 Day200` solves the part two of the given puzzle using the `part2` method
