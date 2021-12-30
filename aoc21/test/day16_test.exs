defmodule Day16Test do
  use ExUnit.Case
  import Day16

  setup do
    {:ok,
     packet_literal_value: "D2FE28",
     packet_op_lt0: "38006F45291200",
     packet_op_lt1: "EE00D40C823060"}
  end

  test "decode" do
    assert decode("D") == <<1::1, 1::1, 0::1, 1::1>>
    assert decode("D2") == <<1::1, 1::1, 0::1, 1::1, 0::1, 0::1, 1::1, 0::1>>
  end

  test "parse_packet literal_value", %{packet_literal_value: packet_literal_value} do
    assert packet_literal_value |> decode |> parse_packet ==
             {%{version: 6, type_id: 4, value: <<2021::size(12)>>}, <<0::3>>}
  end

  test "parse_packet op_lt0", %{packet_op_lt0: packet_op_lt0} do
    {packet, _} = packet_op_lt0 |> decode |> parse_packet
    assert packet.version == 1
    assert packet.type_id == 6

    assert packet.value == [
             %{version: 6, type_id: 4, value: <<10::size(4)>>},
             %{version: 2, type_id: 4, value: <<20::size(8)>>}
           ]
  end

  test "parse_packet op_lt1", %{packet_op_lt1: packet_op_lt1} do
    {packet, _} = packet_op_lt1 |> decode |> parse_packet
    assert packet.version == 7
    assert packet.type_id == 3

    assert packet.value == [
             %{version: 2, type_id: 4, value: <<1::size(4)>>},
             %{version: 4, type_id: 4, value: <<2::size(4)>>},
             %{version: 1, type_id: 4, value: <<3::size(4)>>}
           ]
  end

  test "calculate literal" do
    packet = "D2FE28" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 2021
  end

  test "calculate sum" do
    packet = "C200B40A82" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 3
  end

  test "calculate product" do
    packet = "04005AC33890" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 54
  end

  test "calculate min" do
    packet = "880086C3E88112" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 7
  end

  test "calculate max" do
    packet = "CE00C43D881120" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 9
  end

  test "calculate >" do
    packet = "F600BC2D8F" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 0
  end

  test "calculate <" do
    packet = "D8005AC2A8F0" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 1
  end

  test "calculate ==" do
    packet = "9C005AC2F8F0" |> decode |> parse_all_packets |> List.first()
    assert packet |> calculate == 0
  end

  test "part 1 ex1" do
    assert "8A004A801A8002F478" |> part_1 == 16
  end

  test "part 1 ex2" do
    assert "620080001611562C8802118E34" |> part_1 == 12
  end

  test "part 1 ex3" do
    assert "C0015000016115A2E0802F182340" |> part_1 == 23
  end

  test "part 1 ex4" do
    assert "A0016C880162017C3686B18A3D4780" |> part_1 == 31
  end

  test "part 2" do
    assert "9C0141080250320F1802104A08" |> part_2() == 1
  end
end
