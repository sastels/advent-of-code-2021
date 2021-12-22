defmodule Day10 do
  def is_opening?("("), do: true
  def is_opening?("["), do: true
  def is_opening?("{"), do: true
  def is_opening?("<"), do: true
  def is_opening?(_), do: false

  def is_matching?("(", ")"), do: true
  def is_matching?("[", "]"), do: true
  def is_matching?("{", "}"), do: true
  def is_matching?("<", ">"), do: true
  def is_matching?(_, _), do: false

  def first_error(s) do
    s
    |> String.graphemes()
    |> Enum.reduce({[], nil}, fn c, {stack, error} ->
      cond do
        error != nil ->
          {stack, error}

        is_opening?(c) ->
          {[c | stack], nil}

        length(stack) == 0 ->
          {stack, c}

        true ->
          [c_open | rest] = stack

          if is_matching?(c_open, c) do
            {rest, nil}
          else
            {rest, c}
          end
      end
    end)
  end

  def score(")"), do: 3
  def score("]"), do: 57
  def score("}"), do: 1197
  def score(">"), do: 25137
  def score("("), do: 1
  def score("["), do: 2
  def score("{"), do: 3
  def score("<"), do: 4

  def part_1(contents) do
    String.split(contents, "\n", trim: true)
    |> Enum.map(&first_error/1)
    |> Enum.map(&Kernel.elem(&1, 1))
    |> Enum.reject(&is_nil/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def score_completion_list(x) do
    x
    |> Enum.reduce(0, fn c, acc ->
      acc * 5 + score(c)
    end)
  end

  def part_2(contents) do
    scores =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(&first_error/1)
      |> Enum.filter(&is_nil(elem(&1, 1)))
      |> Enum.map(&Kernel.elem(&1, 0))
      |> Enum.map(&score_completion_list/1)
      |> Enum.sort()

    scores |> Enum.fetch!(div(length(scores), 2))
  end

  def main do
    {:ok, contents} = File.read("data/day10.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
