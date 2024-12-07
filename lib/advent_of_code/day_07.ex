defmodule AdventOfCode.Day07 do
  def part1(filename \\ "priv/day_07.txt") do
    prepare_data(filename)
    |> Enum.map(fn line ->
      [result, rest] = String.split(line, ":")

      result = String.to_integer(result)

      numbers =
        String.trim(rest)
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      valid = valid?({result, numbers}, [&Kernel.+/2, &Kernel.*/2])

      {result, valid}
    end)
    |> Enum.reduce(0, fn a, acc ->
      case a do
        {result, true} -> acc + result
        {_, false} -> acc
      end
    end)
  end

  defp valid?({total, [num]}, _), do: total == num

  defp valid?({total, [num, next | rest]}, operators) do
    Enum.any?(operators, fn op ->
      valid?({total, [op.(num, next) | rest]}, operators)
    end)
  end

  defp concat(a, b), do: String.to_integer("#{a}#{b}")

  def part2(filename \\ "priv/day_07.txt") do
    prepare_data(filename)
    |> Enum.map(fn line ->
      [result, rest] = String.split(line, ":")

      result = String.to_integer(result)

      numbers =
        String.trim(rest)
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      valid = valid?({result, numbers}, [&Kernel.+/2, &Kernel.*/2, &concat/2])

      {result, valid}
    end)
    |> Enum.reduce(0, fn a, acc ->
      case a do
        {result, true} -> acc + result
        {_, false} -> acc
      end
    end)
  end

  defp prepare_data(filename) do
    File.cwd!()
    |> Path.join(filename)
    |> File.stream!()
    |> Enum.map(fn f -> f end)
  end
end
