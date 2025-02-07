defmodule TorrentManager.Bencode do
  def decode(<<first, _rest::binary>> = input) when first in ?0..?9, do: decode_string(input)
  def decode(<<"i", rest::binary>>), do: decode_integer(rest)
  def decode(<<"l", rest::binary>>), do: decode_list(rest, [])
  def decode(<<"d", rest::binary>>), do: decode_dict(rest, %{})
  @moduledoc """
  Módulo responsável por decodificar arquivos no formato Bencode, comumente usado em arquivos .torrent
  """

  @doc """
  Decodifica uma string no formato Bencode e retorna uma tupla com o valor decodificado e o restante da string.

  ## Exemplos

      iex> TorrentManager.Bencode.decode("4:spam")
      {"spam", ""}

      iex> TorrentManager.Bencode.decode("i42e")
      {42, ""}

      iex> TorrentManager.Bencode.decode("l4:spami42ee")
      {["spam", 42], ""}

      iex> TorrentManager.Bencode.decode("d3:foo3:bar5:hello5:worlde")
      {%{"foo" => "bar", "hello" => "world"}, ""}

  """
  @spec decode(binary()) :: {String.t() | integer() | list() | map(), binary()}

  defp decode_string(binary) do
    [size, rest] = String.split(binary, ":", parts: 2)
    size = String.to_integer(size)
    <<string::binary-size(size), remainder::binary>> = rest
    {string, remainder}
  end

  defp decode_integer(binary) do
    [num, rest] = String.split(binary, "e", parts: 2)
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
