defmodule Day14 do
  def frequencies(list),
    do: list |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)

  def parse_template(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.reject(&String.contains?(&1, "->"))
    |> List.first()
  end

  def parse_rule(s) do
    s
    |> String.replace(" -> ", "")
    |> String.graphemes()
    |> then(fn [a, b, c] -> %{(a <> b) => a <> c <> b} end)
  end

  def parse_rules(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.filter(&String.contains?(&1, "->"))
    |> Enum.map(&parse_rule/1)
    |> Enum.reduce(%{}, &Map.merge/2)
  end

  def apply_rules_to_pair(pair, rules), do: Map.get(rules, pair, pair)

  def apply_rules(s, rules) do
    last_char = String.graphemes(s) |> List.last()

    (s
     |> String.graphemes()
     |> Enum.chunk_every(2, 1)
     |> Enum.map(&Enum.join/1)
     |> Enum.map(&apply_rules_to_pair(&1, rules))
     |> Enum.map(fn s -> s |> String.graphemes() |> Enum.drop(-1) |> Enum.join() end)
     |> Enum.join()) <> last_char
  end

  def apply_rules(s, rules, n) do
    Range.new(1, n)
    |> Enum.reduce(s, fn n, acc ->
      IO.inspect(n)
      apply_rules(acc, rules)
    end)
  end

  def part_1(contents) do
    template = parse_template(contents)
    rules = parse_rules(contents)

    letter_frequencies = apply_rules(template, rules, 10) |> String.graphemes() |> frequencies()

    max_freq = letter_frequencies |> Enum.map(&elem(&1, 1)) |> Enum.max()
    min_freq = letter_frequencies |> Enum.map(&elem(&1, 1)) |> Enum.min()
    max_freq - min_freq
  end

  def part_2(contents) do
    template = parse_template(contents)
    rules = parse_rules(contents)

    letter_frequencies = apply_rules(template, rules, 40) |> String.graphemes() |> frequencies()

    max_freq = letter_frequencies |> Enum.map(&elem(&1, 1)) |> Enum.max()
    min_freq = letter_frequencies |> Enum.map(&elem(&1, 1)) |> Enum.min()
    max_freq - min_freq
  end

  def main do
    {:ok, contents} = File.read("data/day14.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
