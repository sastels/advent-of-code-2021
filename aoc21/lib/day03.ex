# useful:
# iex -S mix
# recompile()

defmodule Day03 do
  def transpose(rows), do: rows |> List.zip() |> Enum.map(&Tuple.to_list/1)

  def parse_bits(s),
    do: s |> String.graphemes() |> Enum.map(fn c -> c |> Integer.parse() |> elem(0) end)

  def list_to_num(list) do
    list
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join("")
    |> Integer.parse(2)
    |> elem(0)
  end

  def part_1(data) do
    bits =
      data
      |> Enum.map(&parse_bits/1)
      |> transpose()
      |> Enum.map(fn x ->
        if Enum.sum(x) > length(x) / 2 do
          1
        else
          0
        end
      end)

    gamma = bits |> list_to_num()
    epsilon = bits |> Enum.map(fn x -> 1 - x end) |> list_to_num()
    gamma * epsilon
  end

  def part_2(data) do
    data
  end

  def main do
    {:ok, contents} = File.read("data/day03.txt")
    data = contents |> String.split("\n", trim: true)

    IO.inspect(part_1(data), label: "part 1")
    IO.inspect(part_2(data), label: "part 2")
  end
end
