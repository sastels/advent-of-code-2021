# useful:
# iex -S mix
# recompile()

defmodule Day03 do
  def parse_bits(s) do
    s
  end

  def part_1(data) do
    data
  end

  def part_2(data) do
    data
  end

  def main do
    {:ok, contents} = File.read("data/day03.txt")

    data = contents |> String.split("\n", trim: true) |> Enum.map(&parse_bits/1)

    IO.inspect(part_1(data), label: "part 1")
    IO.inspect(part_2(data), label: "part 2")
  end
end
