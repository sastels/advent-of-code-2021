defmodule Day06 do
  # @spec parse_data(String.t()) :: list(line_t)

  def part_1(contents) do
    contents
    |> String.split("\n", trim: true)
  end

  def part_2(contents) do
    contents
    |> String.split("\n", trim: true)
  end

  def main do
    {:ok, contents} = File.read("data/day06.txt")
    IO.inspect(part_1(contents), label: "part 1")
    IO.inspect(part_2(contents), label: "part 2")
  end
end
