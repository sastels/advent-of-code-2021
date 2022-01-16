defmodule Day18Test do
  use ExUnit.Case
  import Day18

  setup do
    {:ok,
     contents: """
     hi there
     """}
  end

  test "count_depth" do
    assert count_depth("[1,2]") == 0
    assert count_depth("[5,[5,2]") == 1
    assert count_depth("d,],[1,2]]") == -2
  end

  test "first_simple_snail" do
    assert "]" |> first_simple_snail == ["]"]
    assert "[1,2]" |> first_simple_snail == ["", "[1,2]", ""]
    assert "[1,[2,3]]" |> first_simple_snail == ["[1,", "[2,3]", "]"]
  end

  test "first_depth_n" do
    assert "[[[[[9,8],1],2],3],4]" |> first_depth_n(4) == ["[[[[", "[9,8]", ",1],2],3],4]"]
    assert "[7,[6,[5,[4,[3,2]]]]]" |> first_depth_n(4) == ["[7,[6,[5,[4,", "[3,2]", "]]]]"]
    assert "[[6,[5,[4,[31,222]]]],1]" |> first_depth_n(4) == ["[[6,[5,[4,", "[31,222]", "]]],1]"]
    assert "[1,2]" |> first_depth_n(4) == ["[1,2]"]
    assert "[[1,2],[[3,3],[4,5]]]" |> first_depth_n(4) == ["[[1,2],[[3,3],[4,5]]]"]
  end

  test "first_number" do
    assert "hi" |> first_number == ["hi"]
    assert "[[61,[5,[4,[" |> first_number == ["[[", 61, ",[5,[4,["]
  end

  test "last_number" do
    assert "hi" |> last_number == ["hi"]
    assert "[[61,[5,[41,[" |> last_number == ["[[61,[5,[", 41, ",["]
  end

  test "explode" do
    assert ["[[[[", "[9,8]", ",1],2],3],4]"] |> explode == "[[[[0,9],2],3],4]"
    assert ["[7,[6,[5,[4,", "[3,2]", "]]]]"] |> explode == "[7,[6,[5,[7,0]]]]"
    assert ["[[6,[5,[4,", "[3,2]", "]]],1]"] |> explode == "[[6,[5,[7,0]]],3]"
  end

  test "try_explode" do
    assert "[1,2]" |> try_explode == {"[1,2]", false}
    assert "[[1,2],[[3,3],[4,5]]]" |> try_explode == {"[[1,2],[[3,3],[4,5]]]", false}
    assert "[[[[[9,8],1],2],3],4]" |> try_explode == {"[[[[0,9],2],3],4]", true}

    assert "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]" |> try_explode ==
             {"[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]", true}
  end

  test "try_split" do
    assert "10" |> try_split == {"[5,5]", true}

    assert "[[[[0,7],4],[15,[0,13]]],[1,1]]" |> try_split ==
             {"[[[[0,7],4],[[7,8],[0,13]]],[1,1]]", true}
  end

  test "reduce" do
    assert "[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]" |> reduce ==
             "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"

    assert ""
  end

  test "add_2" do
    assert add_2("[1,2]", "[3,[4,5]]") == "[[1,2],[3,[4,5]]]"
    assert add_2("[[[[4,3],4],4],[7,[[8,4],9]]]", "[1,1]") == "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"
  end

  # @tag :skip
  # test "part 1", %{contents: contents} do
  #   assert contents |> part_1() == nil
  # end

  # @tag :skip
  # test "part 2", %{contents: contents} do
  #   assert contents |> part_2() == nil
  # end
end
