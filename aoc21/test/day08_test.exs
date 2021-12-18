defmodule Day08Test do
  use ExUnit.Case
  import Day08

  setup do
    {:ok,
     contents: """
     be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
     edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
     fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
     fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
     aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
     fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
     dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
     bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
     egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
     gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
     """}
  end

  test "parse_line" do
    assert parse_line("be cfb | fd cefdb ") ==
             {["be", "bcf"], ["df", "bcdef"]}
  end

  test "break_easy" do
    words =
      "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
      |> parse_line()
      |> elem(0)

    easy = %{7 => "abd", 1 => "ab", 4 => "abef", 8 => "abcdefg"}
    assert break_easy(words) == easy
  end

  test "break_length_6" do
    words =
      "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
      |> parse_line()
      |> elem(0)

    easy = break_easy(words)

    assert break_length_6("bcdefg", easy) == %{
             7 => "abd",
             1 => "ab",
             4 => "abef",
             8 => "abcdefg",
             6 => "bcdefg"
           }

    assert break_length_6("abcdef", easy) == %{
             7 => "abd",
             1 => "ab",
             4 => "abef",
             8 => "abcdefg",
             9 => "abcdef"
           }

    assert break_length_6("abcdeg", easy) == %{
             7 => "abd",
             1 => "ab",
             4 => "abef",
             8 => "abcdefg",
             0 => "abcdeg"
           }
  end

  test "break_length_5" do
    code = %{
      7 => "abd",
      1 => "ab",
      4 => "abef",
      8 => "abcdefg",
      6 => "bcdefg",
      9 => "abcdef",
      0 => "abcdeg"
    }

    assert break_length_5("fbcad", code) == Map.put(code, 3, "fbcad")
    assert break_length_5("cdfbe", code) == Map.put(code, 5, "cdfbe")
    assert break_length_5("gcdfa", code) == Map.put(code, 2, "gcdfa")
  end

  test "crack" do
    words =
      "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
      |> parse_line()
      |> elem(0)

    assert crack(words) ==
             %{
               7 => "abd",
               1 => "ab",
               4 => "abef",
               8 => "abcdefg",
               6 => "bcdefg",
               9 => "abcdef",
               0 => "abcdeg",
               3 => "abcdf",
               5 => "bcdef",
               2 => "acdfg"
             }
  end

  test "decrypt" do
    code = %{
      7 => "abd",
      1 => "ab",
      4 => "abef",
      8 => "abcdefg",
      6 => "bcdefg",
      9 => "abcdef",
      0 => "abcdeg",
      3 => "abcdf",
      5 => "bcdef",
      2 => "acdfg"
    }

    words =
      "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
      |> parse_line()
      |> elem(1)

    assert decrypt(words, code) == [5, 3, 5, 3]
  end

  test "part 1", %{contents: contents} do
    assert contents |> part_1() == 26
  end

  test "part 2", %{contents: contents} do
    assert contents |> part_2() == 61229
  end
end
