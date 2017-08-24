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

  @type error_type :: :invalid_api_key | :not_found | :station_offline | :invalid_ip | String.t
  @type error_message :: String.t
  @type error :: {error_type, error_message}

  @doc """
  Gets the forecast for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.forecast/1` instead.*
  """
  @spec get(Query.t) :: {:ok, Wunderground.Forecast.Result.t} | {:error, error}
  def get({:us, state, city}) do
    get_from_api(state <> "/" <> city)
  end
  def get({:us_zip, zipcode}) do
    zipcode
    |> Integer.to_string()
    |> get_from_api()
  end
  def get({:international, country, city}) do
    get_from_api(country <> "/" <> city)
  end
  def get({:geo, lat, lng}) do
    location_string = Float.to_string(lat) <> "," <> Float.to_string(lng)
    get_from_api(location_string)
  end
  def get({:airport, airport_code}) do
    get_from_api(airport_code)
  end
  def get({:pws, pws_id}) do
    get_from_api("pws:" <> pws_id)
  end
  def get({:auto_ip}) do
    get_from_api("auto_ip")
  end
  def get({:auto_ip, {_, _, _, _} = ip}) do
    case :inet_parse.ntoa(ip) do
      {:error, reason} ->
        {:error, {:invalid_ip, to_string(reason)}}

      ip_charlist when is_list(ip_charlist) ->
        get_from_api("auto_ip", "?geo_ip=#{to_string ip_charlist}")
    end
  end
  def get({:auto_ip, _}) do
    msg = """
    Invalid argument for Wunderground.Conditions.get({:auto_ip, ip})

      The given ip address should be a tuple with four integers, eg:

      {127, 0, 0, 1}
    """
    raise ArgumentError, message: msg
  end
  def get(_) do
    msg = """
    Invalid argument for Wunderground.Conditions.get/1

      The given argument should be one of:

      - {:us, state, city}
      - {:us_zip, zipcode}
      - {:international, country, city}
      - {:geo, lat, lng}
      - {:airport, airport_code}
      - {:pws, pws_id}
      - {:auto_ip}
    """
    raise ArgumentError, message: msg
  end

  # ---------------------------------------- PRIVATE HELPER
  @spec get_from_api(String.t, String.t) :: {:ok, Wunderground.Forecast.Result.t} | {:error, error}
  defp get_from_api(location_string, query_string \\ "") do
    case API.get("/forecast/q/" <> location_string <> ".json" <> query_string) do
      {:ok, response} ->
        decode_body(response.body)

      {:error, error} ->
        Logger.warn "Error while trying to get the forecast with query: #{location_string}"
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
