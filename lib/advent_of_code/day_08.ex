defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Utils.Board

  def part1(filename \\ "priv/day_08.txt") do
    {board, max_x, max_y} = prepare_data(filename)

    # Board.print(board, max_x, max_y)

    existing_antennas =
      board
      |> Enum.filter(fn {_, val} ->
        Regex.match?(~r/[A-Za-z0-9]/, val)
      end)

    board = check_until(existing_antennas, {board, max_x, max_y})
    Board.print(board, max_x, max_y)

    board
    |> Enum.filter(fn {_, val} ->
      Regex.match?(~r/#.?/, val)
    end)
    |> Enum.count()
  end

  def part2(filename \\ "priv/day_08.txt") do
    {board, max_x, max_y} = prepare_data(filename)

    Board.print(board, max_x, max_y)

    existing_antennas =
      board
      |> Enum.filter(fn {_, val} ->
        Regex.match?(~r/[A-Za-z0-9]/, val)
      end)

    board = check_until(existing_antennas, {board, max_x, max_y})
    Board.print(board, max_x, max_y)

    board
    |> Enum.filter(fn {_, val} ->
      Regex.match?(~r/#.?/, val)
    end)
    |> Enum.count()
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

  defp check_until([], {board, _max_x, _max_y}), do: board

  defp check_until([antenna | remaining_antennas], {board, max_x, max_y}) do
    board = place_antinode(remaining_antennas, antenna, {board, max_x, max_y})

    check_until(remaining_antennas, {board, max_x, max_y})
  end

  defp place_antinode([], _, {board, max_x, max_y}), do: board

  defp place_antinode(
         [{{ox, oy}, oval} = other_antenna | antennas],
         {{x, y}, val},
         {board, max_x, max_y}
       ) do
    board =
      if val == oval do
        # IO.puts("deploying antinodes for #{val} at (#{x}, #{y}) against:")
        # IO.inspect(other_antenna)

        dx = x - ox
        dy = y - oy

        # IO.puts("(#{x + dx},#{y + dy})")
        # IO.puts("(#{ox - dx},#{oy - dy})")

        board
        |> replace_node({x + dx, y + dy})
        |> replace_node({ox - dx, oy - dy})
      else
        board
      end

    place_antinode(antennas, {{x, y}, val}, {board, max_x, max_y})
  end

  defp replace_node(board, coords) do
    case Map.get(board, coords) do
      "." ->
        Map.replace(board, coords, "#")

      "#" ->
        board

      nil ->
        board

      "" ->
        board

      val ->
        if String.starts_with?(val, "#") do
          board
        else
          Map.replace(board, coords, "##{val}")
        end
    end
  end
end
