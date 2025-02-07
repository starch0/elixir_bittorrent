defmodule TorrentManager.Torrent do
  defstruct [
    :name,
    :size,
    :tracker_url
  ]

  def new(decoded_content) do
    info = decoded_content.info

    %__MODULE__{
      name: info.name,
      size: get_size(info),
      tracker_url: decoded_content.announce
    }
  end

  defp get_size(info) do
    if Map.has_key?(info, :length) do
      info.length
    else
      info.files
      |> Enum.map(fn file -> file.length end)
      |> Enum.sum()
    end
  end
end
