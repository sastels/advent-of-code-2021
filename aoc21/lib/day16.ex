defmodule Day16 do
  require Integer

  @type packet_t :: %{version: integer, type_id: integer, value: term}

  def decode(s) do
    s_length = String.length(s)
    s = if Integer.is_odd(s_length), do: s <> "0", else: s
    bs = Base.decode16!(s)
    # chop off the padding if needed
    <<n::s_length*4, _::bitstring>> = bs
    <<n::s_length*4>>
  end

  # type 4
  def parse_packet(<<version::3, 4::3, data::bitstring>>) do
    {value, rest} = parse_literal_value(data)
    {%{version: version, type_id: 4, value: value}, rest}
  end

  # operator, length type id 0
  def parse_packet(<<version::3, type_id::3, 0::1, subpackets_length::15, data::bitstring>>) do
    <<subpacket_data::size(subpackets_length), rest::bitstring>> = data
    packets = parse_all_packets(<<subpacket_data::size(subpackets_length)>>)

    {%{
       version: version,
       type_id: type_id,
       value: packets
     }, rest}
  end

  # operator, length type id 1
  def parse_packet(<<version::3, type_id::3, 1::1, number_of_subpackets::11, data::bitstring>>) do
    {packets, rest} = parse_n_packets(number_of_subpackets, data)

    {%{
       version: version,
       type_id: type_id,
       value: packets
     }, rest}
  end

  def parse_all_packets(data) do
    {packet, rest} = parse_packet(data)

    if Kernel.bit_size(rest) >= 11 do
      [packet, parse_all_packets(rest)] |> List.flatten()
    else
      [packet]
    end
  end

  def parse_n_packets(n, data) do
    {packet, rest} = parse_packet(data)

    if n > 1 do
      {rest_of_packets, rest_of_data} = parse_n_packets(n - 1, rest)
      {List.flatten([packet, rest_of_packets]), rest_of_data}
    else
      {[packet], rest}
    end
  end

  def parse_literal_value(<<0::1, n::4, rest::bitstring>>), do: {<<n::4>>, rest}

  def parse_literal_value(<<1::1, n::4, rest::bitstring>>) do
    {rest_of_n, rest_of_bits} = parse_literal_value(rest)
    {<<n::4, rest_of_n::bitstring>>, rest_of_bits}
  end

  def calculate(%{version: _, type_id: 4, value: <<data::bitstring>>}) do
    padding = rem(bit_size(data), 8)
    :binary.decode_unsigned(<<0::size(padding), data::bitstring>>)
  end

  def calculate(%{version: _, type_id: 0, value: packets}),
    do: packets |> Enum.map(&calculate/1) |> Enum.sum()

  def calculate(%{version: _, type_id: 1, value: packets}),
    do: packets |> Enum.map(&calculate/1) |> Enum.product()

  def calculate(%{version: _, type_id: 2, value: packets}),
    do: packets |> Enum.map(&calculate/1) |> Enum.min()

  def calculate(%{version: _, type_id: 3, value: packets}),
    do: packets |> Enum.map(&calculate/1) |> Enum.max()

  def calculate(%{version: _, type_id: 5, value: [p0, p1]}),
    do: if(calculate(p0) > calculate(p1), do: 1, else: 0)

  def calculate(%{version: _, type_id: 6, value: [p0, p1]}),
    do: if(calculate(p0) < calculate(p1), do: 1, else: 0)

  def calculate(%{version: _, type_id: 7, value: [p0, p1]}),
    do: if(calculate(p0) == calculate(p1), do: 1, else: 0)

  def sum_version_numbers(packets) do
    packets
    |> Enum.reduce(0, fn packet, acc ->
      if packet.type_id == 4,
        do: acc + packet.version,
        else: acc + packet.version + sum_version_numbers(packet.value)
    end)
  end

  def part_1(contents) do
    contents |> String.trim() |> decode |> parse_all_packets |> sum_version_numbers
  end

  def part_2(contents) do
    contents |> String.trim() |> decode |> parse_all_packets |> List.first() |> calculate()
  end

  def main do
    {:ok, contents} = File.read("data/day16.txt")
    IO.inspect(contents |> part_1(), label: "part 1")
    IO.inspect(contents |> part_2(), label: "part 2")
  end
end
