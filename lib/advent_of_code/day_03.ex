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
    |> Enum.flat_map(fn line ->
      Regex.scan(~r/(?>mul\(\d+,\d+\))|(?>do\(\))|(?>don't\(\))/, line)
      |> List.flatten()
    end)
    |> Enum.reduce({true, 0}, fn instruction, {continue, total} ->
      case {continue, instruction} do
        {_, "do()"} -> {true, total}
        {_, "don't()"} -> {false, total}
        {true, instruction} -> {true, mul(instruction) + total}
        {false, _} -> {false, total}
      end
    end)
    |> elem(1)
  end

  defp prepare_data(filename) do
    File.cwd!()
    |> Path.join(filename)
    |> File.stream!()
    |> Enum.map(fn f -> f end)
  end

  defp mul(string) do
    string
    |> String.replace("mul(", "")
    |> String.replace(")", "")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&(&1 * &2))
  end
end
