defmodule GraphTest do
  use ExUnit.Case
  import Graph

  test "new, no argument" do
    assert new() == %{}
  end

  test "new with data" do
    assert new("a-b\nb-c") ==
             %{"a" => %{"b" => 1}, "b" => %{"a" => 1, "c" => 1}, "c" => %{"b" => 1}}
  end

  test "new with space separated data" do
    assert new("a-b   b-c") ==
             %{"a" => %{"b" => 1}, "b" => %{"a" => 1, "c" => 1}, "c" => %{"b" => 1}}
  end

  test "add_vertex" do
    graph = new()
    graph = add_vertex(graph, "a")
    assert graph == %{"a" => %{}}
    graph = add_vertex(graph, "bb")
    assert graph == %{"a" => %{}, "bb" => %{}}
    graph = add_vertex(graph, "bb")
    assert graph == %{"a" => %{}, "bb" => %{}}
  end

  test "delete vertex" do
    assert new("a-b\nb-c") |> delete_vertex("a") == new("b-c")
    assert new("a-b\nb-c") |> delete_vertex("b") == %{"a" => %{}, "c" => %{}}
  end

  test "add_directed_edge" do
    assert add_directed_edge(new(), {"aa", "b", 2}) == %{"aa" => %{"b" => 2}, "b" => %{}}
  end

  test "add_edge from string (undirected, weight 1)" do
    assert add_edge(new(), "aa-b") == %{"aa" => %{"b" => 1}, "b" => %{"aa" => 1}}
  end

  test "successor_vertices" do
    assert new("a-b b-c a-d z-a") |> successor_vertices("a") == ["b", "d", "z"]
  end
end
