defmodule Day10Test do
  use ExUnit.Case
  import Day10

  setup do
    {:ok,
     contents: """
     [({(<(())[]>[[{[]{<()<>>
     [(()[<>])]({[<{<<[]>>(
     {([(<{}[<>[]}>{[]{[(<()>
     (((({<>}<{<{<>}{[]{[]{}
     [[<[([]))<([[{}[[()]]]
     [{[{({}]{}}([{[{{{}}([]
     {<[[]]>}<{[{[{[]{()[[[]
     [<(<(<(<{}))><([]([]()
     <{([([[(<>()){}]>(<<{{
     <{([{{}}[<[[[<>{}]]]>[]]
     """}
  end

  test "irst_error" do
    assert first_error("{([(<{}[<>[]}>{[]{[(<()>") |> elem(1) == "}"
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 26397
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 288_957
  end
end
