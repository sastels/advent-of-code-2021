defmodule Graph do
  @type graph_t :: map
  @type vertex_t :: String.t()
  @type edge_t :: {vertex_t(), vertex_t(), number()}

  @spec new() :: graph_t()
  def new(), do: %{}

  @spec new(String.t()) :: graph_t()
  def new(edge_data) do
    edge_data
    |> String.split(~r/\s+/, trim: true)
    |> Enum.reduce(new(), &add_edge(&2, &1))
  end

  @spec vertices(graph_t()) :: list(vertex_t())
  def vertices(graph), do: Map.keys(graph)

  @spec add_vertex(graph_t(), vertex_t()) :: graph_t()
  def add_vertex(graph, v) do
    if Enum.member?(Graph.vertices(graph), v) do
      graph
    else
      Map.put(graph, v, %{})
    end
  end

  @spec delete_vertex(graph_t(), vertex_t()) :: graph_t()
  def delete_vertex(graph, v) do
    if Enum.member?(Graph.vertices(graph), v) do
      graph
      |> Map.keys()
      |> Enum.reduce(graph, fn key, graph ->
        Map.update!(graph, key, fn edges -> Map.delete(edges, v) end)
      end)
      |> Map.delete(v)
    else
      graph
    end
  end

  # directed with weight
  @spec add_directed_edge(graph_t(), edge_t()) :: graph_t()
  def add_directed_edge(graph, {x, y, weight}) do
    graph = graph |> add_vertex(x) |> add_vertex(y)
    x_edges = graph |> Map.fetch!(x) |> Map.put(y, weight)
    Map.put(graph, x, x_edges)
  end

  # undirected weight 1
  @spec add_edge(graph_t(), String.t()) :: graph_t()
  def add_edge(graph, line) do
    [x, y] = String.split(line, "-")
    graph |> add_directed_edge({x, y, 1}) |> add_directed_edge({y, x, 1})
  end

  @spec successor_vertices(graph_t(), vertex_t()) :: list(vertex_t())
  def successor_vertices(graph, v) do
    graph |> Map.fetch!(v) |> Map.keys()
  end
end
