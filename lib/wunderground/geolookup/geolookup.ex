defmodule Wunderground.Geolookup do
  @moduledoc """
  Handles API requests for handling Geolookup of a given location.
  """

  alias Wunderground.Query
  alias Wunderground.API

  @derive [Poison.Encoder]

  defstruct ~w(type country country_iso3166 country_name state city tz_short tz_long lat lon zip
               magic nearby_weather_stations wmo l requesturl wuiurl)a

  @typedoc """
  The Wunderground.Geolookup struct.

  ## Example

      %Wunderground.Geolookup{
        city: "Tokyo (Haneda) International",
        country: "JP",
        country_iso3166: "JP",
        country_name: "Japan",
        l: "/q/zmw:00000.58.47671",
        lat: "35.55305481",
        lon: "139.78111267",
        magic: "58",
        nearby_weather_stations: %Wunderground.Geolookup.NearbyWeatherStations{
          airport: %Wunderground.Geolookup.StationWrapper{station: []},
          pws: %Wunderground.Geolookup.StationWrapper{station: []}
        },
        requesturl: "global/stations/47671.html",
        state: "13",
        type: "INTLCITY",
        tz_long: "Asia/Tokyo",
        tz_short: "JST",
        wmo: "47671",
        wuiurl: "https://www.wunderground.com/global/stations/47671.html",
        zip: "00000"
      }

  """
  @type t :: %__MODULE__{
    type: String.t,
    country: String.t,
    country_iso3166: String.t,
    country_name: String.t,
    state: String.t,
    city: String.t,
    tz_short: String.t,
    tz_long: String.t,
    lat: String.t,
    lon: String.t,
    zip: String.t,
    magic: String.t,
    nearby_weather_stations: Wunderground.Geolookup.NearbyWeatherStations.t,
    wmo: String.t,
    l: String.t,
    requesturl: String.t,
    wuiurl: String.t
  }

  @doc """
  Does a Geolookup for the given query tuple.

  *Isn't really intended to be used directly. Use `Wunderground.astronomy/1` instead.*
  """
  @spec get(Query.t) :: {:ok, __MODULE__.t} | {:error, API.error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    API.geolookup(query)
  end
end
