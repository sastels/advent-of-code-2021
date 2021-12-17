# counts

defmodule Day08 do
  def parse_line(s) do
    [s1, s2] = String.split(s, ~r/\s*\|\s*/, trim: true)
    patterns = s1 |> String.split(~r/\s+/, trim: true) |> Enum.map(&String.graphemes/1)
    values = s2 |> String.split(~r/\s+/, trim: true) |> Enum.map(&String.graphemes/1)
    {patterns, values}
  end

  def part_1(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&elem(&1, 1))
    |> Enum.concat()
    |> Enum.filter(fn x -> Enum.member?([2, 4, 3, 7], length(x)) end)
    |> Enum.count()
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day08.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
