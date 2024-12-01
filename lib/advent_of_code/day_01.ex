defmodule AdventOfCode.Day01 do
  def part1(filename \\ "priv/day_01.txt") do
    {first, second} = prepare_data(filename)

    Enum.zip(Enum.sort(first), Enum.sort(second))
    |> Enum.map(fn {a, b} ->
      abs(a - b)
    end)
    |> Enum.sum()
  end

  def part2(filename \\ "priv/day_01.txt") do
    {first, second} = prepare_data(filename)

    first
    |> Enum.map(fn num ->
      Enum.count(second, fn n -> n == num end) * num
    end)
    |> Enum.sum()
  end

  defp prepare_data(filename) do
    stream =
      File.cwd!()
      |> Path.join(filename)
      |> File.stream!()

    first =
      stream
      |> Enum.map(fn line ->
        [f, _] = String.split(line)
        String.to_integer(f)
      end)

    second =
      stream
      |> Enum.map(fn line ->
        [_, s] = String.split(line)
        String.to_integer(s)
      end)

    {first, second}
  end
end
