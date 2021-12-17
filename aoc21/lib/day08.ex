defmodule Day08 do
  def sort_string(s) do
    s
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join()
  end

  def parse_line(s) do
    [s1, s2] = String.split(s, ~r/\s*\|\s*/, trim: true)
    patterns = s1 |> String.split(~r/\s+/, trim: true) |> Enum.map(&sort_string/1)
    values = s2 |> String.split(~r/\s+/, trim: true) |> Enum.map(&sort_string/1)
    {patterns, values}
  end

  def part_1(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&elem(&1, 1))
    |> Enum.concat()
    |> Enum.filter(fn s -> Enum.member?([2, 4, 3, 7], String.length(s)) end)
    |> Enum.count()
  end

  def break_easy(words) do
    words
    |> Enum.reduce(%{}, fn w, acc ->
      cond do
        String.length(w) == 2 -> Map.put(acc, 1, w)
        String.length(w) == 4 -> Map.put(acc, 4, w)
        String.length(w) == 3 -> Map.put(acc, 7, w)
        String.length(w) == 7 -> Map.put(acc, 8, w)
        true -> acc
      end
    end)
  end

  def word_contains?(word, sub_word) do
    MapSet.subset?(MapSet.new(String.graphemes(sub_word)), MapSet.new(String.graphemes(word)))
  end

  # 6 - 6 - does not contain 1
  # 9 - 6 - contains 1 and 4
  # 0 - 6
  def break_length_6(word, code) do
    cond do
      not word_contains?(word, Map.get(code, 1)) -> Map.put(code, 6, word)
      word_contains?(word, Map.get(code, 4)) -> Map.put(code, 9, word)
      true -> Map.put(code, 0, word)
    end
  end

  # 3 - 5 - contains 1
  # 5 - 5 - is contained in 6
  # 2 - 5
  def break_length_5(word, code) do
    cond do
      word_contains?(word, Map.get(code, 1)) -> Map.put(code, 3, word)
      word_contains?(Map.get(code, 6), word) -> Map.put(code, 5, word)
      true -> Map.put(code, 2, word)
    end
  end

  def crack(words) do
    code = break_easy(words)

    code =
      words
      |> Enum.filter(fn s -> String.length(s) == 6 end)
      |> Enum.reduce(code, &break_length_6/2)

    words
    |> Enum.filter(fn s -> String.length(s) == 5 end)
    |> Enum.reduce(code, &break_length_5/2)
  end

  def decrypt(words, code) do
    inverse_code = Map.new(code, fn {key, val} -> {val, key} end)
    words |> Enum.map(&Map.get(inverse_code, &1))
  end

  def part_2(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {patterns, values} ->
      code = crack(patterns)
      decrypt(values, code)
    end)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def main do
    {:ok, contents} = File.read("data/day08.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
