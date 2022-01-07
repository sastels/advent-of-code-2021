defmodule Snail do
  defstruct [:id, :parent, :left, :right]
  @type t :: %__MODULE__{id: String.t(), parent: String.t(), left: term, right: term}

  @type id :: String.t()
  @type system :: map()

  @spec find_commas(String.t()) :: list(non_neg_integer())
  def find_commas(s) do
    s
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {c, _} -> c == "," end)
    |> Enum.map(&elem(&1, 1))
  end

  @spec is_top_level_comma?(String.t(), non_neg_integer) :: boolean
  def is_top_level_comma?(s, index) do
    s
    |> String.slice(0, index)
    |> String.graphemes()
    |> Enum.map(fn c ->
      case c do
        "[" -> 1
        "]" -> -1
        _ -> 0
      end
    end)
    |> Enum.sum() == 1
  end

  @spec parse(system(), String.t()) :: {system(), id() | integer}
  def parse(sys, s) do
    case Integer.parse(s) do
      :error ->
        comma_index =
          s
          |> find_commas()
          |> Enum.filter(&is_top_level_comma?(s, &1))
          |> List.first()

        {sys, snail_left} = parse(sys, String.slice(s, 1, comma_index - 1))

        {sys, snail_right} =
          parse(sys, String.slice(s, comma_index + 1, String.length(s) - comma_index - 2))

        snail = %Snail{id: UUID.uuid4(), parent: "", left: snail_left, right: snail_right}

        ## set parent id in snail left and right if they're snail indices

        sys =
          if is_integer(snail_left),
            do: sys,
            else:
              Map.update!(sys, snail_left, fn v ->
                %Snail{id: v.id, parent: snail.id, left: v.left, right: v.right}
              end)

        sys =
          if is_integer(snail_right),
            do: sys,
            else:
              Map.update!(sys, snail_right, fn v ->
                %Snail{id: v.id, parent: snail.id, left: v.left, right: v.right}
              end)

        {Map.put(sys, snail.id, snail), snail.id}

      _ ->
        {sys, String.to_integer(s)}
    end
  end

  @spec to_string(system, id() | integer()) :: String.t()
  def to_string(sys, id) do
    if is_integer(id) do
      Integer.to_string(id)
    else
      snail = Map.get(sys, id)
      "[" <> to_string(sys, snail.left) <> "," <> to_string(sys, snail.right) <> "]"
    end
  end

  @spec inspect(system, id() | integer) :: :ok
  def inspect(sys, id), do: IO.puts(to_string(sys, id))

  @spec add(system(), id(), id()) :: {system(), id()}
  def add(sys, id0, id1) do
    id = UUID.uuid4()
    s = %Snail{id: id, parent: "", left: id0, right: id1}
    sys = Map.put(sys, id, s)
    s0 = Map.get(sys, id0)
    s0 = %Snail{id: id0, parent: id, left: s0.left, right: s0.right}
    Map.put(sys, id0, s0)
    s1 = Map.get(sys, id1)
    s1 = %Snail{id: id1, parent: id, left: s1.left, right: s1.right}
    {Map.put(sys, id1, s1), id}
  end

  @spec root(map()) :: String.t()
  def root(sys) do
    sys |> Enum.find(fn {_k, v} -> v.id == "" end) |> elem(0)
  end
end
