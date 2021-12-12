defmodule Day04 do
  @spec parse_data(String.t()) :: {[number], [[number]]}
  def split_to_ints(s, split_on) do
    s
    |> String.split(split_on, trim: true)
    |> Enum.map(fn s -> Integer.parse(s) |> elem(0) end)
  end

  def parse_data(contents) do
    [number_string | board_strings] = contents |> String.split("\n", trim: true)

    numbers = number_string |> split_to_ints(",")

    boards =
      board_strings
      |> Enum.map(&split_to_ints(&1, " "))
      |> Enum.chunk_every(5)
      |> Enum.map(&Enum.concat/1)

    {numbers, boards}
  end

  def mark_boards(number, boards) do
    boards
    |> Enum.concat()
    |> Enum.map(fn x -> if x == number, do: :marked, else: x end)
    |> Enum.chunk_every(25)
  end

  def row_marked?(row, board) do
    0..4 |> Enum.reduce(true, fn n, state -> state && Enum.at(board, row * 5 + n) == :marked end)
  end

  def col_marked?(col, board) do
    0..4 |> Enum.reduce(true, fn n, state -> state && Enum.at(board, n * 5 + col) == :marked end)
  end

  def is_winning_board?(board) do
    row_marked = 0..4 |> Enum.reduce(false, fn n, state -> state || row_marked?(n, board) end)
    col_marked = 0..4 |> Enum.reduce(false, fn n, state -> state || col_marked?(n, board) end)
    row_marked || col_marked
  end

  def play(numbers, boards) do
  end

  def part_1(contents) do
    parse_data(contents)
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day04.txt")

    IO.inspect(part_1(contents), label: "part 1")
    IO.inspect(part_2(contents), label: "part 2")
  end
end
