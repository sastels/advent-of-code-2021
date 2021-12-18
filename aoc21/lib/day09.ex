defmodule Day09 do
  def part_1(contents) do
    contents
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
