defmodule Wunderground.Autocomplete.API do
  @moduledoc false

  alias Wunderground.Autocomplete.Response
  alias Wunderground.Autocomplete.Result

  use HTTPoison.Base

  @type error :: Wunderground.API.error

  # ---------------------------------------- HTTPoison specific
  @spec process_url(String.t) :: String.t
  def process_url(url) do
    "http://autocomplete.wunderground.com/" <> url
  end

  def process_response_body(body) do
    Poison.decode!(body, as: %Response{
      RESULTS: [%Result{}]
    })
  end

  @spec get_autocomplete(String.t) :: {:ok, Wunderground.Autocomplete.t} |
                                      {:error, error}
  def get_autocomplete(query) do
    encoded_query = URI.encode(query)

    case get("aq?query=" <> encoded_query) do
      {:ok, %HTTPoison.Response{body: %Response{} = body, status_code: 200}} ->
        grouped = body
        |> Map.get(:RESULTS)
        |> Enum.group_by(fn (x) -> x.type end)

        autocomplete = %Wunderground.Autocomplete{
          cities: grouped["city"],
          hurricanes: grouped["hurricanes"]
        }

        {:ok, autocomplete}

      {:error, error} ->
        {:error, error}
    end
  end
end
