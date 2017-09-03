defmodule Wunderground.Autocomplete.City do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(c l lat lon name tz tzs zmw)a

  @typedoc """
  The Wunderground.Autocomplete.City struct.

  ## Example

      %Wunderground.Autocomplete.City{
        c: "US",
        l: "/q/zmw:94102.1.99999",
        lat: "37.779999",
        lon: "-122.419998"
        name: "San Francisco, California",
        tz: "America/Los_Angeles",
        tzs: "PDT",
        zmw: "94102.1.99999",
      }

  """
  @type t :: %__MODULE__{
    c: String.t, # country
    l: String.t,
    lat: String.t,
    lon: String.t,
    name: String.t,
    tz: String.t,
    tzs: String.t,
    zmw: String.t,
  }
end
