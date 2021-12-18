defmodule Day09 do
  def get_low_points(grid) do
    Range.new(0, tuple_size(grid[:data]) - 1)
    |> Enum.map(&Grid.position_to_point(&1, grid))
    |> Enum.map(fn p -> {p, Grid.get(p, grid), Grid.min_adjacent(p, grid)} end)
    |> Enum.filter(fn {_, n, adj} -> n < adj end)
    |> Enum.map(fn {p, _, _} -> p end)
  end

  def part_1(contents) do
    grid = Grid.new(contents)

    grid
    |> get_low_points()
    |> Enum.map(fn p -> 1 + Grid.get(p, grid) end)
    |> Enum.sum()
  end

  def just_keep_peaks(grid) do
    data =
      grid[:data]
      |> Tuple.to_list()
      |> Enum.map(fn x ->
        cond do
          x == 9 -> 10_000_000
          true -> -1
        end
      end)

    %{grid | data: List.to_tuple(data)}
  end

  def part_2(contents) do
    grid = Grid.new(contents)

    grid |> Grid.inspect()

    low_points = get_low_points(grid)

    basin_grid =
      low_points
      |> Enum.with_index()
      |> Enum.reduce(just_keep_peaks(grid), fn {p, index}, acc ->
        Grid.put(acc, p, index)
      end)
  end

  def main do
    {:ok, contents} = File.read("data/day09.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
