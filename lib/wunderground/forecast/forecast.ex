defmodule Wunderground.Forecast do
  @moduledoc """
  Handles API requests for getting the forecast of a given place.
  """

  alias Wunderground.API
  alias Wunderground.Query
  alias Wunderground.Forecast.Result

  require Logger

  @derive [Poison.Encoder]
  defstruct ~w(response forecast)a

  @type error_type :: :invalid_api_key | :not_found | :station_offline | String.t
  @type error_message :: String.t
  @type error :: {error_type, error_message}

  @doc """
  Gets the forecast for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.forecast/1` instead.*
  """
  @spec get(Query.t) :: {:ok, Wunderground.Forecast.Result.t} | {:error, error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    get_from_api(query)
  end

  # ---------------------------------------- PRIVATE HELPER
  @spec get_from_api(String.t) :: {:ok, Wunderground.Forecast.Result.t} | {:error, error}
  defp get_from_api(query_string) do
    case API.get("/forecast" <> query_string) do
      {:ok, response} ->
        decode_body(response.body)

      {:error, error} ->
        Logger.warn "Error while trying to get the forecast with query: #{query_string}"
        Logger.warn inspect(error)
        {:error, error}
    end
  end

  @spec decode_body(String.t) :: {:ok, Result.t} | {:error, error}
  defp decode_body(body) do
    decoded = Poison.decode!(body, as: %__MODULE__{
      response: %Wunderground.API.Response{
        error: %Wunderground.API.Error{}
      },
      forecast: %Result{
        txt_forecast: %Wunderground.Forecast.TXTForecast{
          forecastday: [%Wunderground.Forecast.TXTForecastDay{}]
        },
        simpleforecast: %Wunderground.Forecast.SimpleForecast{
          forecastday: [
            %Wunderground.Forecast.SimpleForecastDay{
              avewind: %Wunderground.Forecast.SimpleForecastDay.Wind{},
              date: %Wunderground.Forecast.SimpleForecastDay.Date{},
              high: %Wunderground.Forecast.SimpleForecastDay.Temperature{},
              low: %Wunderground.Forecast.SimpleForecastDay.Temperature{},
              maxwind: %Wunderground.Forecast.SimpleForecastDay.Wind{},
              qpf_allday: %Wunderground.Forecast.SimpleForecastDay.Rain{},
              qpf_day: %Wunderground.Forecast.SimpleForecastDay.Rain{},
              qpf_night: %Wunderground.Forecast.SimpleForecastDay.Rain{},
              snow_allday: %Wunderground.Forecast.SimpleForecastDay.Snow{},
              snow_day: %Wunderground.Forecast.SimpleForecastDay.Snow{},
              snow_night: %Wunderground.Forecast.SimpleForecastDay.Snow{}
            }
          ]
        },
      }
    })

    case decoded.response.error do
      %Wunderground.API.Error{description: description, type: "querynotfound"} ->
        {:error, {:not_found, description}}

      # TODO: handle elsewhere, maybe this whole function should go to Query or API
      %Wunderground.API.Error{description: description, type: "keynotfound"} ->
        {:error, {:invalid_api_key, description}}

      %Wunderground.API.Error{type: "Station:OFFLINE"} ->
        msg = "The station you're looking for either doesn't exist or is simply offline right now."
        {:error, {:station_offline, msg}}

      %Wunderground.API.Error{description: description, type: error_type} ->
        Logger.warn "Unhandled error: " <> error_type
        Logger.warn "with description: " <> description
        {:error, {error_type, description}}

      _ ->
        {:ok, decoded.forecast}
    end
  end
end
