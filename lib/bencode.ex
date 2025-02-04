defmodule TorrentManager.Bencode do
  def decode(<<first, _rest::binary>> = input) when first in ?0..?9, do: decode_string(input)
  def decode(<<"i", rest::binary>>), do: decode_integer(rest)
  def decode(<<"l", rest::binary>>), do: decode_list(rest, [])
  def decode(<<"d", rest::binary>>), do: decode_dict(rest, %{})

  defp decode_string(binary) do
    [size, rest] = String.split(binary, ":", parts: 2)
    size = String.to_integer(size)
    <<string::binary-size(size), remainder::binary>> = rest
    {string, remainder}
  end

  defp decode_integer(<<"i", rest::binary>>) do
    [num, rest] = String.split(rest, "e", parts: 2)
    {String.to_integer(num), rest}
  end

  defp decode_list(<<"e", rest::binary>>, acc), do: {Enum.reverse(acc), rest}

  defp decode_list(binary, acc) do
    {value, rest} = decode(binary)
    decode_list(rest, [value | acc])
  end

  defp decode_dict(<<"e", rest::binary>>, acc), do: {acc, rest}

  defp decode_dict(binary, acc) do
    {key, rest} = decode(binary)
    {value, rest} = decode(rest)
    decode_dict(rest, Map.put(acc, key, value))
  end
end
