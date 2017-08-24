defmodule Wunderground.API do
  @moduledoc false

  use HTTPoison.Base

  require Logger

  @type error_type :: :invalid_api_key | :not_found | :station_offline | String.t
  @type error_message :: String.t
  @type error :: {error_type, error_message}

  @spec get_conditions(String.t) :: {:ok, Wunderground.Conditions.Observation.t} | {:error, error}
  def get_conditions(query) do
    case get_with_query("/conditions", query) do
      {:ok, body} ->
        {:ok, body.current_observation}
      {:error, error} ->
        {:error, error}
    end
  end

  @spec get_forecast(String.t) :: {:ok, Wunderground.Forecast.Result.t} | {:error, error}
  def get_forecast(query) do
    case get_with_query("/forecast", query) do
      {:ok, body} ->
        {:ok, body.forecast}
      {:error, error} ->
        {:error, error}
    end
  end

  defp get_with_query(path, query) do
    case get(path <> query) do
      {:error, error} ->
        Logger.warn "Error while #{path <> query}:"
        Logger.warn inspect(error)
        {:error, error}

      {:ok, %HTTPoison.Response{body: {:error, error}, status_code: 200}} ->
        {:error, error}

      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, body}
    end
  end

  # ---------------------------------------- HTTPoison specific
  @spec process_url(String.t) :: String.t
  def process_url(url) do
    "http://api.wunderground.com/api/" <> api_key() <> url
  end

  def process_response_body(body) do
    decoded = Poison.decode!(body, as: %Wunderground.API.ResponseBody{
      response: %Wunderground.API.Response{
        error: %Wunderground.API.Error{}
      },
      current_observation: %Wunderground.Conditions.Observation{
        image: %Wunderground.Conditions.Image{},
        display_location: %Wunderground.Conditions.DisplayLocation{},
        observation_location: %Wunderground.Conditions.ObservationLocation{}
      },
      forecast: %Wunderground.Forecast.Result{
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

      %Wunderground.API.Error{description: description, type: "keynotfound"} ->
        {:error, {:invalid_api_key, description}}

      %Wunderground.API.Error{type: "Station:OFFLINE"} ->
        msg = "The station you're looking for either doesn't exist or is simply offline right now."
        {:error, {:station_offline, msg}}

      %Wunderground.API.Error{description: description, type: error_type} ->
        Logger.warn "Unhandled error: " <> error_type
        Logger.warn "with description: " <> description
        {:error, {error_type, description}}

      nil ->
        decoded
    end
  end

  # ---------------------------------------- PRIVATE HELPER
  @spec api_key :: String.t
  defp api_key, do: Application.get_env(:wunderground, :api_key) || ""
end
