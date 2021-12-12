defmodule Day05 do
  @typedoc """
  width, height, data
  """
  @type grid_t :: %{width: integer, height: integer, data: tuple}

  @typedoc """
  x, y
  """
  @type point_t :: {integer, integer}

  @typedoc """
  start, end
  """
  @type line_t :: {point_t, point_t}

  @spec parse_point(String.t()) :: point_t
  def parse_point(s),
    do:
      s
      |> String.split(~r/\s*,\s*/, trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

  @spec parse_line(String.t()) :: line_t
  def parse_line(s),
    do: s |> String.split(~r/\s*->\s*/, trim: true) |> Enum.map(&parse_point/1) |> List.to_tuple()

  @spec empty_grid(number, number, any) :: grid_t
  def empty_grid(width, height, default),
    do: %{width: width, height: height, data: Tuple.duplicate(default, width * height)}

  # @spec grid_get_point(grid, number, number) :: grid_t
  # def grid_get_point(grid, x, y) do
  # end

  # @spec grid_set_point(grid_t, number, number, any) :: grid_t
  # def grid_set_point(grid, x, y) do
  # end

  # @spec add_line_to_grid(line_t, grid_t) :: grid_t
  # def add_line_to_grid(line, grid) do
  # end

  @spec parse_data(String.t()) :: list(line_t)
  def parse_data(contents),
    do: String.split(contents, "\n", trim: true) |> Enum.map(&parse_line/1)

  def part_1(contents) do
    contents
  end

  def part_2(contents) do
    contents
  end
end
