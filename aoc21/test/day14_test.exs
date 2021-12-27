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
    assert "aba\n\na->bb" |> parse_template() == %{"ab" => 1, "ba" => 1}
  end

  test "parse_template 2" do
    assert "aaab\n\na->bb" |> parse_template() == %{"ab" => 1, "aa" => 2}
  end

  test "parse_rule" do
    assert "ch -> b" |> parse_rule() == %{"ch" => ["cb", "bh"]}
  end

  test "parse_rules" do
    assert "aba\n\nab -> c\nqb -> H" |> parse_rules() ==
             %{"ab" => ["ac", "cb"], "qb" => ["qH", "Hb"]}
  end

  test "apply_rules_to_pair", %{contents: contents} do
    rules = parse_rules(contents)
    assert "CH" |> apply_rules_to_pair(rules) == ["CB", "BH"]
    assert "ab" |> apply_rules_to_pair(rules) == ["ab"]
  end

  test "apply_rules", %{contents: contents} do
    rules = parse_rules(contents)

    assert %{"NN" => 1, "NC" => 1, "CB" => 1} |> apply_rules(rules) ==
             %{"NC" => 1, "CN" => 1, "NB" => 1, "BC" => 1, "CH" => 1, "HB" => 1}
  end

  test "apply_rules 2", %{contents: contents} do
    rules = parse_rules(contents)

    assert %{"NN" => 1, "NC" => 1, "CB" => 1} |> apply_rules(rules, 2) ==
             %{
               "NB" => 2,
               "BC" => 2,
               "CC" => 1,
               "CN" => 1,
               "BB" => 2,
               "CB" => 2,
               "BH" => 1,
               "HC" => 1
             }
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() |> Enum.member?(1588)
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() |> Enum.member?(2_188_189_693_529)
  end
end
