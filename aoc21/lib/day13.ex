defmodule Day13 do
  @spec parse_points(String.t()) :: list
  def parse_points(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reject(&String.contains?(&1, "fold"))
    |> Enum.map(&Grid.string_to_point/1)
  end

  @spec parse_fold_string(String.t()) :: %{dir: String.t(), value: integer}
  def parse_fold_string(s) do
    Regex.named_captures(~r/along (?<dir>.)=(?<value>.*)/, s)
    |> then(fn x -> %{dir: x["dir"], value: String.to_integer(x["value"])} end)
  end

  @spec parse_folds(String.t()) :: list
  def parse_folds(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.filter(&String.contains?(&1, "fold"))
    |> Enum.map(&parse_fold_string/1)
  end

  @spec parse_input(String.t()) :: %{folds: list, points: list}
  def parse_input(input) do
    %{points: parse_points(input), folds: parse_folds(input)}
  end

  def fold(points, "y", value) do
    points
    |> Enum.map(fn {x, y} ->
      {x, if(y > value, do: 2 * value - y, else: y)}
    end)
    |> Enum.uniq()
  end

  def fold(points, "x", value) do
    points
    |> Enum.map(fn {x, y} ->
      {if(x > value, do: 2 * value - x, else: x), y}
    end)
    |> Enum.uniq()
  end

  def part_1(contents) do
    folds = contents |> parse_folds()
    first_fold = folds |> List.first()

    contents
    |> parse_points()
    |> fold(first_fold.dir, first_fold.value)
    |> Enum.count()
  end

  def part_2(contents) do
    folds = contents |> parse_folds()
    points = contents |> parse_points()

    final_points =
      folds
      |> Enum.reduce(points, fn f, points ->
        fold(points, f.dir, f.value)
      end)

    width = 1 + (final_points |> Enum.map(&elem(&1, 0)) |> Enum.max())
    height = 1 + (final_points |> Enum.map(&elem(&1, 1)) |> Enum.max())

    final_points
    |> Enum.reduce(Grid.new(width, height), &Grid.put(&1, &2, 1))
    |> Grid.inspect()
  end

  def main do
    {:ok, contents} = File.read("data/day13.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
