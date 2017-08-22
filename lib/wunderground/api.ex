defmodule Wunderground.API do
  @moduledoc false
  use HTTPoison.Base

  # ---------------------------------------- HTTPoison specific
  @spec process_url(String.t) :: String.t
  def process_url(url) do
    "http://api.wunderground.com/api/" <> api_key() <> url <> ".json"
  end

  # ---------------------------------------- PRIVATE HELPER
  @spec api_key() :: String.t
  defp api_key(), do: Application.get_env(:wunderground, :api_key) || ""
end
