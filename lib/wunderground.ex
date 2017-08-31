defmodule Wunderground do
  @moduledoc """
  Wunderground, a basic API wrapper for talking to the Weather Underground HTTP API.
  """

  alias Wunderground.API
  alias Wunderground.Almanac
  alias Wunderground.Astronomy
  alias Wunderground.Conditions
  alias Wunderground.Forecast
  alias Wunderground.Geolookup
  alias Wunderground.Query

  @doc """
  🌤 Gets the current conditions for the given location.

  ## Parameters

    - query: A `Wunderground.Query` that represents a location.

  ## Example

      {:ok, conditions} = Wunderground.conditions({:us, "CA", "San_Francisco"})

  """
  @spec conditions(Query.t) :: {:ok, Conditions.t} | {:error, API.error}
  defdelegate conditions(query), to: Conditions, as: :get

  @doc """
  📅 Gets the forecast for the given location.

  ## Parameters

    - query: A `Wunderground.Query` that represents a location.

  ## Example

      {:ok, forecast} = Wunderground.forecast({:pws, "KCASANFR70"})

  """
  @spec forecast(Query.t) :: {:ok, Forecast.t} | {:error, API.error}
  defdelegate forecast(query), to: Forecast, as: :get

  @doc """
  🌖 Gets the astronomy for the given location.

  ## Parameters

    - query: A `Wunderground.Query` that represents a location.

  ## Example

      {:ok, astronomy} = Wunderground.astronomy({:geo, 37.8, -122.4})

  """
  @spec astronomy(Query.t) :: {:ok, Astronomy.t} | {:error, API.error}
  defdelegate astronomy(query), to: Astronomy, as: :get

  @doc """
  🗓 Gets the almanac for the given location.

  ## Parameters

    - query: A `Wunderground.Query` that represents a location.

  ## Example

      {:ok, almanac} = Wunderground.almanac({:airport, "KJFK"})

  """
  @spec almanac(Query.t) :: {:ok, Almanac.t} | {:error, API.error}
  defdelegate almanac(query), to: Almanac, as: :get

  @doc """
  🗺 Gets the Geolookup for the given location.

  ## Parameters

    - query: A `Wunderground.Query` that represents a location.

  ## Example

      {:ok, geolookup} = Wunderground.geolookup({:international, "Australia", "Sydney"})

  """
  @spec geolookup(Query.t) :: {:ok, Geolookup.t} | {:error, API.error}
  defdelegate geolookup(query), to: Geolookup, as: :get
end
