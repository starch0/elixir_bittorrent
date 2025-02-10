defmodule TorrentManager.TrackerClient do
  @peer_id "-EM0001-" <> :crypto.strong_rand_bytes(12)

  def announce(torrent) do
    url = build_announce_url(torrent)

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        {decoded, _} = TorrentManager.Bencode.decode(body)
        parse_response(decoded)

      {:error, reason} ->
        {:error, "#{inspect(reason)}"}
    end
  end

  defp build_announce_url(torrent) do
    params = URI.encode_query(%{
      "info_hash" => URI.encode(torrent.info_hash),
      "peer_id" => @peer_id,
      "port" => 6881,
      "uploaded" => 0,
      "downloaded" => 0,
      "left" => torrent.size,
      "compact" => 1
    })

    "#{torrent.tracker_url}?#{params}"
  end

  defp parse_response(response) do
    %{
      interval: response.interval,
      peers: decode_peers(response.peers)
    }
  end

  defp decode_peers(<<>>), do: []
  defp decode_peers(peers) do
    for <<ip1, ip2, ip3, ip4, port::16 <- peers>> do
      %{
        ip: "#{ip1}.#{ip2}.#{ip3}.#{ip4}",
        port: port
      }
    end
  end
end
