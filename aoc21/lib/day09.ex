defmodule Day09 do
  def part_1(contents) do
    grid = Grid.new(contents)

    Range.new(0, tuple_size(grid[:data]) - 1)
    |> Enum.map(&Grid.position_to_point(&1, grid))
    |> Enum.map(fn p -> {Grid.get(p, grid), Grid.min_adjacent(p, grid)} end)
    |> Enum.filter(fn {n, adj} -> n < adj end)
    |> Enum.map(fn {n, _} -> n + 1 end)
    |> Enum.sum()
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day09.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
