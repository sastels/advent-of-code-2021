defmodule Utils do
  def frequencies(list),
    do: list |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)

  def flatten_one_level(list),
    do:
      Enum.flat_map(list, fn
        x when is_list(x) -> x
        x -> [x]
      end)
end
