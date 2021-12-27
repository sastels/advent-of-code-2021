defmodule Day14 do
  def parse_template(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.reject(&String.contains?(&1, "->"))
    |> List.first()
    |> String.graphemes()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&Enum.join/1)
    |> Utils.frequencies()
  end

  def parse_rule(s) do
    s
    |> String.replace(" -> ", "")
    |> String.graphemes()
    |> then(fn [a, b, c] -> %{(a <> b) => [a <> c, c <> b]} end)
  end

  def parse_rules(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.filter(&String.contains?(&1, "->"))
    |> Enum.map(&parse_rule/1)
    |> Enum.reduce(%{}, &Map.merge/2)
  end

  def apply_rules_to_pair(pair, rules), do: Map.get(rules, pair, [pair])

  def list_of_tuples_to_map(tuples) do
    tuples |> Enum.reduce(%{}, fn {k, v}, acc -> Map.update(acc, k, v, fn cv -> cv + v end) end)
  end

  def apply_rules(pairs, rules) do
    pairs
    |> Enum.map(fn {k, v} ->
      apply_rules_to_pair(k, rules) |> Enum.map(fn p -> {p, v} end)
    end)
    |> Utils.flatten_one_level()
    |> list_of_tuples_to_map()
  end

  def apply_rules(s, rules, n) do
    Range.new(1, n)
    |> Enum.reduce(s, fn _, acc -> apply_rules(acc, rules) end)
  end

  def spread(contents, n) do
    template = parse_template(contents)
    rules = parse_rules(contents)

    pair_frequencies = apply_rules(template, rules, n)

    # drop last letter of every pair
    # might not work if the last letter is important - need +/- 1
    letter_frequencies =
      pair_frequencies
      |> Enum.map(fn {p, v} -> {p |> String.graphemes() |> List.first(), v} end)
      |> list_of_tuples_to_map()

    max_freq = letter_frequencies |> Enum.map(&elem(&1, 1)) |> Enum.max()
    min_freq = letter_frequencies |> Enum.map(&elem(&1, 1)) |> Enum.min()
    diff = max_freq - min_freq
    [diff - 1, diff, diff + 1]
  end

  def part_1(contents) do
    spread(contents, 10)
  end

  def part_2(contents) do
    spread(contents, 40)
  end

  def main do
    {:ok, contents} = File.read("data/day14.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
