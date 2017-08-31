defmodule Wunderground.Geolookup.AirportStation do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(city state country icao lat lon)a

  @typedoc """
  The Wunderground.Geolookup.AirportStation struct.

  ## Example

      %Wunderground.Geolookup.AirportStation{
        city: "Tokyo",
        country: "JP",
        icao: "RJTT",
        lat: "35.54999924",
        lon: "139.77999878",
        state: ""
      }

  """
  @type t :: %__MODULE__{
    city: String.t,
    state: String.t,
    country: String.t,
    icao: String.t,
    lat: String.t,
    lon: String.t
  }
end
