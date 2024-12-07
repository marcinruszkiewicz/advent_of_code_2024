defmodule Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day03

  test "runs the solver for part one" do
    assert Day03.part1("test/examples/day_03.txt") == 161
  end

  test "runs the solver for part two" do
    assert Day03.part2("test/examples/day_03_2.txt") == 48
  end
end
