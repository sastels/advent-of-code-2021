defmodule Day04 do
  def part_1(data) do
    data
  end

  def part_2(data) do
    data
  end

  def main do
    {:ok, contents} = File.read("data/day04.txt")
    data = contents |> String.split("\n", trim: true)

    IO.inspect(part_1(data), label: "part 1")
    IO.inspect(part_2(data), label: "part 2")
  end
end
