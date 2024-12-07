defmodule AdventOfCode.Day03 do
  def part1(filename \\ "priv/day_03.txt") do
    prepare_data(filename)
    |> Enum.map(fn line ->
      Regex.scan(~r/mul\((?<a>\d+),(?<b>\d+)\)/, line, capture: ["a", "b"])
      |> Enum.map(fn [a, b] ->
        String.to_integer(a) * String.to_integer(b)
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2(filename \\ "priv/day_03.txt") do
    prepare_data(filename)
  end

  defp prepare_data(filename) do
    File.cwd!()
    |> Path.join(filename)
    |> File.stream!()
    |> Enum.map(fn f -> f end)
  end
end
