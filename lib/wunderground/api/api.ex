defmodule Wunderground.API do
  @moduledoc false

  use HTTPoison.Base

  require Logger

  @type error_type :: :invalid_api_key | :not_found | :station_offline | :http_error | String.t
  @type error_message :: String.t
  @type error :: {error_type, error_message}

  @spec get_conditions(String.t) :: {:ok, Wunderground.Conditions.t} | {:error, error}
  def get_conditions(query) do
    case get_with_query("/conditions", query) do
      {:ok, body} ->
        {:ok, body.current_observation}
      {:error, error} ->
        {:error, error}
    end
  end

  @spec get_forecast(String.t) :: {:ok, Wunderground.Forecast.t} | {:error, error}
  def get_forecast(query) do
    case get_with_query("/forecast", query) do
      {:ok, body} ->
        {:ok, body.forecast}
      {:error, error} ->
        {:error, error}
    end
  end

  @spec get_astronomy(String.t) :: {:ok, Wunderground.Astronomy.t} | {:error, error}
  def get_astronomy(query) do
    case get_with_query("/astronomy", query) do
      {:ok, body} ->
        {:ok, body.moon_phase}
      {:error, error} ->
        {:error, error}
    end
  end

  @spec get_almanac(String.t) :: {:ok, Wunderground.Almanac.t} | {:error, error}
  def get_almanac(query) do
    case get_with_query("/almanac", query) do
      {:ok, body} ->
        {:ok, body.almanac}
      {:error, error} ->
        {:error, error}
    end
  end

  @spec geolookup(String.t) :: {:ok, Wunderground.Geolookup.t} | {:error, error}
  def geolookup(query) do
    case get_with_query("/geolookup", query) do
      {:ok, body} ->
        {:ok, body.location}
      {:error, error} ->
        {:error, error}
    end
  end

  @spec get_with_query(String.t, String.t) :: {:ok, any} | {:error, error}
  defp get_with_query(path, query) do
    case get(path <> query) do
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, {:http_error, reason}}

      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        case body.response.error do
          %Wunderground.API.Error{description: description, type: "querynotfound"} ->
            {:error, {:not_found, description}}

          %Wunderground.API.Error{description: description, type: "keynotfound"} ->
            {:error, {:invalid_api_key, description}}

          %Wunderground.API.Error{type: "Station:OFFLINE"} ->
            msg = "The station you're looking for either doesn't exist or is simply offline right now."
            {:error, {:station_offline, msg}}

          %Wunderground.API.Error{description: description, type: error_type} ->
            {:error, {error_type, description}}

          nil ->
            {:ok, body}
        end
    end
  end

  # ---------------------------------------- HTTPoison specific
  @spec process_url(String.t) :: String.t
  def process_url(url) do
    "http://api.wunderground.com/api/" <> api_key() <> url
  end

  def process_response_body(body) do
    Poison.decode!(body, as: %Wunderground.API.ResponseBody{
      response: %Wunderground.API.Response{
        error: %Wunderground.API.Error{}
      },
      current_observation: %Wunderground.Conditions{
        image: %Wunderground.Conditions.Image{},
        display_location: %Wunderground.Conditions.DisplayLocation{},
        observation_location: %Wunderground.Conditions.ObservationLocation{}
      },
      forecast: %Wunderground.Forecast{
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
      },
      moon_phase: %Wunderground.Astronomy{
        current_time: %Wunderground.Astronomy.Time{},
        moonrise: %Wunderground.Astronomy.Time{},
        moonset: %Wunderground.Astronomy.Time{},
        sunrise: %Wunderground.Astronomy.Time{},
        sunset: %Wunderground.Astronomy.Time{}
      },
      almanac: %Wunderground.Almanac{
        temp_high: %Wunderground.Almanac.Temperature{
          normal: %Wunderground.Almanac.TemperaturePair{},
          record: %Wunderground.Almanac.TemperaturePair{}
        },
        temp_low: %Wunderground.Almanac.Temperature{
          normal: %Wunderground.Almanac.TemperaturePair{},
          record: %Wunderground.Almanac.TemperaturePair{}
        }
      },
      location: %Wunderground.Geolookup{
        nearby_weather_stations: %Wunderground.Geolookup.NearbyWeatherStations{
          airport: %Wunderground.Geolookup.StationWrapper{
            station: [%Wunderground.Geolookup.AirportStation{}]
          },
          pws: %Wunderground.Geolookup.StationWrapper{
            station: [%Wunderground.Geolookup.PWSStation{}]
          }
        }
      }
    })
  end

  # ---------------------------------------- PRIVATE HELPER
  @spec api_key :: String.t
  defp api_key, do: Application.get_env(:wunderground, :api_key) || ""
end
