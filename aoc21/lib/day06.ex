defmodule Day06 do
  def parse_fish_map(s) do
    s
    |> String.split("\n", trim: true)
    |> Enum.at(0)
    |> String.split(~r/\s*,\s*/, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{0 => 0}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  def step_fish_map(fish) do
    %{
      0 => Map.get(fish, 1, 0),
      1 => Map.get(fish, 2, 0),
      2 => Map.get(fish, 3, 0),
      3 => Map.get(fish, 4, 0),
      4 => Map.get(fish, 5, 0),
      5 => Map.get(fish, 6, 0),
      6 => Map.get(fish, 7, 0) + Map.get(fish, 0, 0),
      7 => Map.get(fish, 8, 0),
      8 => Map.get(fish, 0, 0)
    }
  end

  def part_1(contents) do
    fish = parse_fish_map(contents)

    1..80
    |> Enum.reduce(fish, fn _, state -> step_fish_map(state) end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sum()
  end

  def part_2(contents) do
    fish = parse_fish_map(contents)

    1..256
    |> Enum.reduce(fish, fn _, state -> step_fish_map(state) end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sum()
  end

  def main do
    {:ok, contents} = File.read("data/day06.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
