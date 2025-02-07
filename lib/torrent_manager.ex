defmodule TorrentManager do
  alias TorrentManager.Bencode

  def read_torrent_file(path) do
    case File.read(path) do
      {:ok, content} ->
        {decoded, _} = Bencode.decode(content)
        decoded

      {:error, reason} ->
        {:error, reason}
    end
  end
end
