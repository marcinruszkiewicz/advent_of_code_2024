defmodule AdventOfCode.Day06 do
  def part1(filename \\ "priv/day_06.txt") do
    {board, max_x, max_y} = prepare_data(filename)

    board = move_until(true, {board, max_x, max_y})

    # print(board, max_x, max_y)
    board |> Enum.filter(fn {_, val} -> val == "X" end) |> Enum.count()
  end

  def part2(filename \\ "priv/day_06.txt") do
    prepare_data(filename)
  end

  defp move_until(nil, {board, _max_x, _max_y}), do: board

  defp move_until(_, {board, max_x, max_y}) do
    moved = Enum.find(board, nil, fn {_, val} -> val in ["v", ">", "<", "^"] end)

    board =
      case moved do
        {{x, y}, direction} ->
          move(board, {x, y, direction})

        nil ->
          board
      end

    # print(board, max_x, max_y)

    move_until(moved, {board, max_x, max_y})
  end

  defp move(board, {x, y, "^"}) do
    case Map.get(board, {x, y - 1}) do
      "#" ->
        Map.replace(board, {x, y}, ">")

      _ ->
        Map.replace(board, {x, y}, "X")
        |> Map.replace({x, y - 1}, "^")
    end
  end

  defp move(board, {x, y, "v"}) do
    case Map.get(board, {x, y + 1}) do
      "#" ->
        Map.replace(board, {x, y}, "<")

      _ ->
        Map.replace(board, {x, y}, "X")
        |> Map.replace({x, y + 1}, "v")
    end
  end

  defp move(board, {x, y, ">"}) do
    case Map.get(board, {x + 1, y}) do
      "#" ->
        Map.replace(board, {x, y}, "v")

      _ ->
        Map.replace(board, {x, y}, "X")
        |> Map.replace({x + 1, y}, ">")
    end
  end

  defp move(board, {x, y, "<"}) do
    case Map.get(board, {x - 1, y}) do
      "#" ->
        Map.replace(board, {x, y}, "^")

      _ ->
        Map.replace(board, {x, y}, "X")
        |> Map.replace({x - 1, y}, "<")
    end
  end

  defp print(board, max_x, max_y) do
    Enum.each(0..max_y, fn y ->
      Enum.each(0..max_x, fn x ->
        IO.write(Map.get(board, {x, y}))
      end)

      IO.puts("")
    end)
  end

  defp prepare_data(filename) do
    file =
      File.cwd!()
      |> Path.join(filename)
      |> File.stream!()
      |> Enum.map(fn f -> String.trim(f) |> String.split("") end)

    max_y = Enum.count(file)
    max_x = Enum.count(List.first(file))

    map =
      file
      |> Enum.with_index()
      |> Enum.map(fn {columns, row} ->
        Enum.with_index(columns)
        |> Map.new(fn {val, col} -> {{col, row}, val} end)
      end)
      |> List.flatten()
      |> Enum.reduce(&Map.merge/2)

    {map, max_x, max_y}
  end
end
