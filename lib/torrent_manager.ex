defmodule TorrentManager do
  alias TorrentManager.{Bencode, Torrent}

  def read_torrent_file(path) do
    case File.read(path) do
      {:ok, content} ->
        {decoded, _} = Bencode.decode(content)

        torrent = Torrent.new(decoded)

        IO.puts "\nTorrent Information:"
        IO.puts "Name: #{torrent.name}"
        IO.puts "Size: #{torrent.size} bytes"
        IO.puts "Tracker: #{torrent.tracker_url}"

        {:ok, torrent}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
