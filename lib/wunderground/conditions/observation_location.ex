defmodule Wunderground.Conditions.ObservationLocation do
  @derive [Poison.Encoder]

  defstruct ~w(full city state country country_iso3166 latitude longitude elevation)a

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
