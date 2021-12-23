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
          x == 9 -> :peak
          true -> :unknown
        end
      end)

    %{grid | data: List.to_tuple(data)}
  end

  def set_low_points(grid) do
    get_low_points(grid)
    |> Enum.with_index()
    |> Enum.reduce(just_keep_peaks(grid), fn {p, index}, acc ->
      Grid.put(p, acc, index)
    end)
  end

  def spread_basin(p, grid) do
    value = Grid.get(p, grid)

    cond do
      value == :peak ->
        grid

      value == :unknown ->
        grid

      true ->
        Grid.get_adjacent(p, grid)
        |> Enum.reduce(grid, fn p, acc ->
          if Grid.get(p, acc) == :unknown, do: Grid.put(p, acc, value), else: acc
        end)
    end
  end

  def is_done?(grid) do
    grid[:data] |> Tuple.to_list() |> Enum.filter(fn x -> x == :unknown end) |> Enum.empty?()
  end

  def find_all_basins(grid) do
    grid = grid |> Grid.get_all_points() |> Enum.reduce(grid, &spread_basin(&1, &2))
    if is_done?(grid), do: grid, else: find_all_basins(grid)
  end

  def part_2(contents) do
    Grid.new(contents)
    |> set_low_points()
    |> find_all_basins()
    |> Map.get(:data)
    |> Tuple.to_list()
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
    |> Enum.filter(fn {k, _} -> k != :peak end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(1, &(&1 * &2))
  end

  def main do
    {:ok, contents} = File.read("data/day09.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
