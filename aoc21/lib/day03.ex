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

  def most_common_bit(x), do: if(Enum.sum(x) >= length(x) / 2, do: 1, else: 0)
  def least_common_bit(x), do: if(Enum.sum(x) < length(x) / 2, do: 1, else: 0)

  def filter_data_most_common_bit(n, lists) do
    bit =
      lists
      |> transpose()
      |> Enum.at(n)
      |> most_common_bit()

    Enum.filter(lists, fn x -> Enum.at(x, n) == bit end)
  end

  def filter_data_least_common_bit(n, lists) do
    if length(lists) == 1 do
      lists
    else
      bit =
        lists
        |> transpose()
        |> Enum.at(n)
        |> least_common_bit()

      Enum.filter(lists, fn x -> Enum.at(x, n) == bit end)
    end
  end

  def part_1(data) do
    bits =
      data
      |> Enum.map(&parse_bits/1)
      |> transpose()
      |> Enum.map(&most_common_bit/1)

    gamma = bits |> list_to_num()
    epsilon = bits |> Enum.map(fn x -> 1 - x end) |> list_to_num()
    gamma * epsilon
  end

  def part_2(data) do
    bits =
      data
      |> Enum.map(&parse_bits/1)

    oxygen_generator_rating =
      Range.new(0, length(Enum.at(bits, 0)) - 1)
      |> Enum.reduce(bits, &filter_data_most_common_bit/2)
      |> Enum.at(0)
      |> list_to_num()

    co2_scrubber_rating =
      Range.new(0, length(Enum.at(bits, 0)) - 1)
      |> Enum.reduce(bits, &filter_data_least_common_bit/2)
      |> Enum.at(0)
      |> list_to_num()

    oxygen_generator_rating * co2_scrubber_rating
  end

  def main do
    {:ok, contents} = File.read("data/day03.txt")
    data = contents |> String.split("\n", trim: true)

    IO.inspect(part_1(data), label: "part 1")
    IO.inspect(part_2(data), label: "part 2")
  end
end
