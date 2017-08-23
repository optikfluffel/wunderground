defmodule Wunderground.CurrentConditions.DisplayLocation do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct ~w(full city state state_name country country_iso3166 zip latitude longitude elevation)a

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
