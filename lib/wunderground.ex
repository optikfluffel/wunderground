defmodule Wunderground do
  @moduledoc """
  Wunderground, a basic API wrapper for talking to the Weather Underground HTTP API.
  """

  alias Wunderground.API
  alias Wunderground.Astronomy
  alias Wunderground.Conditions
  alias Wunderground.Forecast
  alias Wunderground.Query

  @doc """
  Gets the current conditions for the given location.

  ## Usage

      # For the US using {:us, state, city} or {:us_zip, zipcode}
      {:ok, conditions} = Wunderground.conditions({:us, "CA", "San_Francisco"})
      {:ok, conditions} = Wunderground.conditions({:us_zip, 60290})

      # International using {:international, country, city}
      {:ok, conditions} = Wunderground.conditions({:international, "Australia", "Sydney"})

      # Via coordinates using {:geo, lat, lng}
      {:ok, conditions} = Wunderground.conditions({:geo, 37.8, -122.4})

      # For an airport using {:airport, airport_code}
      {:ok, conditions} = Wunderground.conditions({:airport, "KJFK"})

      # For a specific personal weather station using {:pws, pws_id}
      {:ok, conditions} = Wunderground.conditions({:pws, "KCASANFR70"})

      # For the GeoIP location of the running machine using {:auto_ip}
      # or any IP address using {:auto_ip, ip_adress}
      {:ok, conditions} = Wunderground.conditions({:auto_ip})
      {:ok, conditions} = Wunderground.conditions({:auto_ip, {185, 1, 74, 1}})
  """
  @spec conditions(Query.t) :: {:ok, Conditions.Observation.t} | {:error, API.error}
  defdelegate conditions(query), to: Conditions, as: :get

  @doc """
  Gets the forecast for the given location.

  ## Usage

      # For the US using {:us, state, city} or {:us_zip, zipcode}
      {:ok, forecast} = Wunderground.forecast({:us, "CA", "San_Francisco"})
      {:ok, forecast} = Wunderground.forecast({:us_zip, 60290})

      # International using {:international, country, city}
      {:ok, forecast} = Wunderground.forecast({:international, "Australia", "Sydney"})

      # Via coordinates using {:geo, lat, lng}
      {:ok, forecast} = Wunderground.forecast({:geo, 37.8, -122.4})

      # For an airport using {:airport, airport_code}
      {:ok, forecast} = Wunderground.forecast({:airport, "KJFK"})

      # For a specific personal weather station using {:pws, pws_id}
      {:ok, forecast} = Wunderground.forecast({:pws, "KCASANFR70"})

      # For the GeoIP location of the running machine using {:auto_ip}
      # or any IP address using {:auto_ip, ip_adress}
      {:ok, forecast} = Wunderground.forecast({:auto_ip})
      {:ok, forecast} = Wunderground.forecast({:auto_ip, {185, 1, 74, 1}})
  """
  @spec forecast(Query.t) :: {:ok, Forecast.Result.t} | {:error, API.error}
  defdelegate forecast(query), to: Forecast, as: :get

  @doc """
  Gets the astronomy for the given location.

  ## Usage

      # For the US using {:us, state, city} or {:us_zip, zipcode}
      {:ok, astronomy} = Wunderground.astronomy({:us, "CA", "San_Francisco"})
      {:ok, astronomy} = Wunderground.astronomy({:us_zip, 60290})

      # International using {:international, country, city}
      {:ok, astronomy} = Wunderground.astronomy({:international, "Australia", "Sydney"})

      # Via coordinates using {:geo, lat, lng}
      {:ok, astronomy} = Wunderground.astronomy({:geo, 37.8, -122.4})

      # For an airport using {:airport, airport_code}
      {:ok, astronomy} = Wunderground.astronomy({:airport, "KJFK"})

      # For a specific personal weather station using {:pws, pws_id}
      {:ok, astronomy} = Wunderground.astronomy({:pws, "KCASANFR70"})

      # For the GeoIP location of the running machine using {:auto_ip}
      # or any IP address using {:auto_ip, ip_adress}
      {:ok, astronomy} = Wunderground.astronomy({:auto_ip})
      {:ok, astronomy} = Wunderground.astronomy({:auto_ip, {185, 1, 74, 1}})
  """
  @spec astronomy(Query.t) :: {:ok, Astronomy.Moonphase.t} | {:error, API.error}
  defdelegate astronomy(query), to: Astronomy, as: :get
end
