defmodule Wunderground do
  @moduledoc """
  Wunderground, a basic API wrapper for talking to the Weather Underground HTTP API.
  """

  alias Wunderground.CurrentConditions
  alias Wunderground.Query

  @type error :: CurrentConditions.error

  @doc """
  Gets the current conditions for the given location.

  ## Usage

      # For the US using {:us, state, city} or {:us_zip, zipcode}
      {:ok, conditions} = Wunderground.current_conditions({:us, "CA", "San_Francisco"})
      {:ok, conditions} = Wunderground.current_conditions({:us_zip, 60290})

      # International using {:international, country, city}
      {:ok, conditions} = Wunderground.current_conditions({:international, "Australia", "Sydney"})

      # Via coordinates using {:geo, lat, lng}
      {:ok, conditions} = Wunderground.current_conditions({:geo, 37.8, -122.4})

      # For an airport using {:airport, airport_code}
      {:ok, conditions} = Wunderground.current_conditions({:airport, "KJFK"})

      # For a specific personal weather station using {:pws, pws_id}
      {:ok, conditions} = Wunderground.current_conditions({:pws, "KCASANFR70"})

      # From the GeoIP of the running machine using {:auto_ip}
      {:ok, conditions} = Wunderground.current_conditions({:auto_ip})
  """
  @spec current_conditions(Query.t) :: {:ok, any} | {:error, error}
  defdelegate current_conditions(query), to: CurrentConditions, as: :get
end
