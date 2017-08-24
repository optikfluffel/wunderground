defmodule Wunderground.Conditions.ObservationLocation do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(full city state country country_iso3166 latitude longitude elevation)a

  @typedoc """
  The Wunderground.Conditions.ObservationLocation struct.

  ## Example

      %Wunderground.Conditions.ObservationLocation{
        city: "Berlin,
        Berlin Mitte",
        country: "DL",
        country_iso3166: "DE",
        elevation: "150 ft",
        full: "Berlin,
        Berlin Mitte,
        BE",
        latitude: "52.520008",
        longitude: "13.404954",
        state: "BE"
      }

  """
  @type t :: %__MODULE__{
    full: String.t,
    city: String.t,
    state: String.t,
    country: String.t,
    country_iso3166: String.t,
    latitude: String.t,
    longitude: String.t,
    elevation: String.t
  }
end
