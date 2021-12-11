defmodule Day03Test do
  use ExUnit.Case

  setup do
    {:ok,
     data: [
       "00100",
       "11110",
       "10110",
       "10111",
       "10101",
       "01111",
       "00111",
       "11100",
       "10000",
       "11001",
       "00010",
       "01010"
     ]}
  end

  test "parse_bits" do
    assert "00101" |> Day03.parse_bits() == [0, 0, 1, 0, 1]
  end

  test "transpose" do
    assert [[0, 1], [0, 0], [1, 1]] |> Day03.transpose() == [[0, 0, 1], [1, 0, 1]]
  end

  test "list_to_num" do
    assert [1, 0, 1, 1] |> Day03.list_to_num() == 11
    assert [0] |> Day03.list_to_num() == 0
    assert [0, 0, 1] |> Day03.list_to_num() == 1
  end

  test "most common_bit" do
    assert [1, 0, 1] |> Day03.common_bit(:most) == 1
    assert [1, 0, 1, 0, 0] |> Day03.common_bit(:most) == 0
    assert [1, 0, 0, 1] |> Day03.common_bit(:most) == 1
  end

  test "least common_bit" do
    assert [1, 0, 1] |> Day03.common_bit(:least) == 0
    assert [1, 0, 1, 0, 0] |> Day03.common_bit(:least) == 1
    assert [1, 0, 0, 1] |> Day03.common_bit(:least) == 0
  end

  test "filter_data_common_bit :most" do
    data = [[1, 1], [0, 0], [1, 0]]
    assert Day03.filter_data_common_bit(0, data, :most) == [[1, 1], [1, 0]]
    assert Day03.filter_data_common_bit(1, data, :most) == [[0, 0], [1, 0]]
  end

  test "part 1", %{data: data} do
    assert data |> Day03.part_1() == 198
  end

  test "part 2", %{data: data} do
    assert data |> Day03.part_2() == 230
  end
end
