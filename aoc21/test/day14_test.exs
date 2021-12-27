defmodule Day14Test do
  use ExUnit.Case
  import Day14

  setup do
    {:ok,
     contents: """
     NNCB

     CH -> B
     HH -> N
     CB -> H
     NH -> C
     HB -> C
     HC -> B
     HN -> C
     NN -> C
     BH -> H
     NC -> B
     NB -> B
     BN -> B
     BB -> N
     BC -> B
     CC -> N
     CN -> C
     """}
  end

  test "parse_template" do
    assert "aba\n\na->bb" |> parse_template() == "aba"
  end

  test "parse_rule" do
    assert "ch -> b" |> parse_rule() == %{"ch" => "cbh"}
  end

  test "parse_rules" do
    assert "aba\n\nab -> c\nqb -> H" |> parse_rules() ==
             %{"ab" => "acb", "qb" => "qHb"}
  end

  test "apply_rules_to_pair", %{contents: contents} do
    rules = parse_rules(contents)
    assert "CH" |> apply_rules_to_pair(rules) == "CBH"
    assert "ab" |> apply_rules_to_pair(rules) == "ab"
  end

  test "apply_rules", %{contents: contents} do
    rules = parse_rules(contents)
    assert "NNCB" |> apply_rules(rules) == "NCNBCHB"
  end

  test "apply_rules 2", %{contents: contents} do
    rules = parse_rules(contents)
    assert "NNCB" |> apply_rules(rules, 2) == "NBCCNBBBCBHCB"
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 1588
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 2_188_189_693_529
  end
end
