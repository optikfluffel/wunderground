defmodule Wunderground.Autocomplete.API do
  @moduledoc false

  alias Wunderground.Autocomplete.Response
  alias Wunderground.Autocomplete.Result
  alias Wunderground.Autocomplete.City
  alias Wunderground.Autocomplete.Hurricane

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
        |> Enum.group_by(&by_type/1, &specify_result/1)

        autocomplete = %Wunderground.Autocomplete{
          cities: grouped["city"],
          hurricanes: grouped["hurricanes"]
        }

        {:ok, autocomplete}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec by_type(Result.t) :: String.t
  defp by_type(%Result{type: type}), do: type

  @spec specify_result(Result.t) :: City.t | Hurricane.t
  defp specify_result(%Result{type: "city"} = result) do
    %City{
      name: result.name,
      c: result.c,
      zmw: result.zmw,
      tz: result.tz,
      tzs: result.tzs,
      l: result.l,
      lat: result.lat,
      lon: result.lon
    }
  end
  defp specify_result(%Result{type: "hurricanes"} = result) do
    %Hurricane{
      name: result.name,
      l: result.l,
      date: result.date,
      strmnum: result.strmnum,
      basin: result.basin,
      damage: result.damage
    }
  end
end
