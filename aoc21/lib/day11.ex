defmodule Day11 do
  def increment_levels(grid) do
    grid
    |> Grid.get_all_points()
    |> Enum.reduce(grid, &Grid.increment/2)
  end

  def flash_if_ready(p, grid) do
    if Grid.get(p, grid) > 9 do
      grid = Grid.put(p, grid, -1000)

      grid =
        Grid.get_surrounding(p, grid)
        |> Enum.reduce(grid, &Grid.increment/2)

      Grid.get_surrounding(p, grid)
      |> Enum.reduce(grid, &flash_if_ready/2)
    else
      grid
    end
  end

  def octo_step(grid) do
    grid = grid |> increment_levels()

    grid =
      grid
      |> Grid.get_all_points()
      |> Enum.reduce(grid, &flash_if_ready/2)

    grid
    |> Grid.get_all_points()
    |> Enum.reduce(grid, fn p, grid -> Grid.put(p, grid, max(0, Grid.get(p, grid))) end)
  end

  def count_zeros(grid) do
    grid[:data] |> Tuple.to_list() |> Enum.count(fn x -> x == 0 end)
  end

  def part_1(contents) do
    grid = Grid.new(contents)

    Range.new(0, 99)
    |> Enum.reduce({0, grid}, fn _, {n, grid} ->
      grid = grid |> octo_step()
      {n + count_zeros(grid), grid}
    end)
    |> elem(0)
  end

  def step_until_synchronized(grid, n) do
    grid = octo_step(grid)

    if count_zeros(grid) == 100 do
      {grid, n + 1}
    else
      step_until_synchronized(grid, n + 1)
    end
  end

  def part_2(contents) do
    Grid.new(contents)
    |> step_until_synchronized(0)
    |> elem(1)
  end

  def main do
    {:ok, contents} = File.read("data/day11.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
