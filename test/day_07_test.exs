defmodule Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day07

  test "runs the solver for part one" do
    assert Day07.part1("test/examples/day_07.txt") == 3749
  end

  test "runs the solver for part two" do
    assert Day07.part2("test/examples/day_07.txt") == 11387
  end
end
