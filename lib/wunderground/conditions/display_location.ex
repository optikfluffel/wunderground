defmodule Wunderground.Conditions.DisplayLocation do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(full city state state_name country country_iso3166 zip latitude longitude elevation)a

  @typedoc """
  The Wunderground.Conditions.DisplayLocation struct.

  ## Example

      %Wunderground.Conditions.DisplayLocation{
        city: "Berlin",
        country: "DL",
        country_iso3166: "DE",
        elevation: "45.1",
        full: "Berlin,
        Germany",
        latitude: "52.52000046",
        longitude: "13.40999985",
        state: "BE",
        state_name: "Germany",
        zip: "00000"
      }

  """
  @type t :: %__MODULE__{
    full: String.t,
    city: String.t,
    state: String.t,
    state_name: String.t,
    country: String.t,
    country_iso3166: String.t,
    zip: String.t,
    latitude: String.t,
    longitude: String.t,
    elevation: String.t
  }
end
