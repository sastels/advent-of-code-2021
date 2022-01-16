defmodule Day18 do
  @type snail :: String.t()

  @spec add(snail, snail) :: snail
  def add(sn0, sn1), do: "[#{sn0},#{sn1}]"

  @spec count_depth(String.t()) :: integer()
  def count_depth(s) do
    s
    |> String.graphemes()
    |> Enum.map(fn c ->
      case c do
        "[" -> 1
        "]" -> -1
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  @spec first_simple_snail(snail()) :: [String.t()]
  def first_simple_snail(sn) do
    Regex.split(~r{\[\d+\,\d+\]}, sn, parts: 2, include_captures: true)
  end

  @spec first_depth_n(String.t(), integer) :: [String.t()]
  def first_depth_n(s, n) do
    split = first_simple_snail(s)

    if length(split) == 1 do
      [s]
    else
      [pre, sn, post] = split

      if count_depth(pre) == n do
        split
      else
        recurse = first_depth_n(post, n - count_depth(pre))

        if length(recurse) == 1 do
          [s]
        else
          [pre <> sn <> recurse[0], recurse[1], recurse[2]]
        end
      end
    end
  end

  @spec first_number(String.t()) :: [String.t() | integer]
  def first_number(s) do
    n = Regex.scan(~r/\d+/, s) |> List.flatten() |> List.first()

    if n == nil do
      [s]
    else
      [pre, post] = String.split(s, n, parts: 2)
      [pre, String.to_integer(n), post]
    end
  end

  @spec last_number(String.t()) :: [String.t() | integer]
  def last_number(s) do
    results = s |> String.reverse() |> first_number

    if length(results) == 1 do
      [s]
    else
      [pre, n, post] = results

      [
        String.reverse(post),
        n |> Integer.to_string() |> String.reverse() |> String.to_integer(),
        String.reverse(pre)
      ]
    end
  end

  @spec explode([String.t()]) :: snail
  def explode(parts) do
    [pre, sn, post] = parts
    [_, n0, _] = first_number(sn)
    [_, n1, _] = last_number(sn)
    pre_last = last_number(pre)
    post_first = first_number(post)

    new_pre =
      if length(pre_last) == 1 do
        pre
      else
        [pre_pre, pre_last_n, pre_post] = pre_last
        pre_pre <> "#{pre_last_n + n0}" <> pre_post
      end

    new_post =
      if length(post_first) == 1 do
        post
      else
        [post_pre, post_first_n, post_post] = post_first
        post_pre <> "#{post_first_n + n1}" <> post_post
      end

    new_pre <> "0" <> new_post
  end

  def try_explode(sn) do
    depth_4 = first_depth_n(sn, 4)

    if length(depth_4) == 1 do
      {sn, false}
    else
      {explode(depth_4), true}
    end
  end

  def part_1(contents) do
    contents
  end

  def part_2(contents) do
    contents
  end

  def main do
    {:ok, contents} = File.read("data/day18.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    # IO.inspect(contents |> part_2(), label: "part 2")
  end
end
