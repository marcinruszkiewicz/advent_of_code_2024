defmodule Day01Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day01

  test "runs the solver for part one" do
    assert Day01.part1("test/examples/day1.txt") == 11
  end

  test "runs the solver for part two" do
    assert Day01.part2("test/examples/day1.txt") == 31
  end
end
