defmodule Wunderground do
  @moduledoc """
  Wunderground, a basic API wrapper for talking to the Weather Underground HTTP API.
  """

  alias Wunderground.Conditions
  alias Wunderground.Conditions.CurrentObservation
  alias Wunderground.Query

  @type error :: Conditions.error

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

      # From the GeoIP of the running machine using {:auto_ip}
      {:ok, conditions} = Wunderground.conditions({:auto_ip})
  """
  @spec conditions(Query.t) :: {:ok, CurrentObservation.t} | {:error, error}
  defdelegate conditions(query), to: Conditions, as: :get
end
