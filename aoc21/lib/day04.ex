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

  def mark_board(number, board) do
    board
    |> Enum.map(fn x -> if x == number, do: :marked, else: x end)
  end

  def mark_boards(number, boards) do
    boards
    |> Enum.map(&mark_board(number, &1))
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

  def sum_board(board) do
    board
    |> Enum.filter(fn x -> x != :marked end)
    |> Enum.sum()
  end

  def play_number({number, index}, {nil, nil, nil, board}) do
    board = mark_board(number, board)

    if is_winning_board?(board) do
      {number, index, number * sum_board(board), board}
    else
      {nil, nil, nil, board}
    end
  end

  def play_number({_, _}, {number, index, score, board}), do: {number, index, score, board}

  # return winning number, index, sum, and board
  def play_board(numbers, board) do
    Enum.zip([numbers, Range.new(0, length(numbers) - 1)])
    |> Enum.reduce({nil, nil, nil, board}, &play_number/2)
  end

  def part_1(contents) do
    {numbers, boards} = parse_data(contents)

    boards
    |> Enum.map(&play_board(numbers, &1))
    |> Enum.reduce({nil, nil}, fn {_, i, s, _}, {index, score} ->
      if i < index, do: {i, s}, else: {index, score}
    end)
    |> elem(1)
  end

  def part_2(contents) do
    {numbers, boards} = parse_data(contents)

    boards
    |> Enum.map(&play_board(numbers, &1))
    |> Enum.reduce({nil, nil}, fn {_, i, s, _}, {index, score} ->
      if i > index, do: {i, s}, else: {index, score}
    end)
    |> elem(1)
  end

  def main do
    {:ok, contents} = File.read("data/day04.txt")

    IO.inspect(part_1(contents), label: "part 1")
    IO.inspect(part_2(contents), label: "part 2")
  end
end
