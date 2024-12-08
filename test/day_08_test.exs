defmodule Day08Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day08

  test "runs the solver for part one" do
    assert Day08.part1("test/examples/day_08.txt") == 14
  end

  test "runs the solver for part two" do
    assert Day08.part2("test/examples/day_08_2.txt") == 9
  end
end
