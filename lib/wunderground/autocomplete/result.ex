defmodule Wunderground.Autocomplete.Result do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(name type c zmw tz tzs l lat lon date strmnum basin damage)a

  @typedoc """
  The Wunderground.Autocomplete.Result struct.

  ## Example

      %Wunderground.Autocomplete.Result{
        name: "San Francisco, California",
        type: "city",
        c: "US",
        zmw: "94102.1.99999",
        tz: "America/Los_Angeles",
        tzs: "PDT",
        l: "/q/zmw:94102.1.99999",
        lat: "37.779999",
        lon: "-122.419998"
        date: "<<hurricanes only>>",
        strmnum: "<<hurricanes only>>",
        basin: "<<hurricanes only>>",
        damage: "<<hurricanes only>>"
      }

  """
  @type t :: %__MODULE__{
    name: String.t,
    type: String.t, # either "city" or "hurricanes"
    c: String.t, # country, city only
    zmw: String.t, # city only
    tz: String.t, # city only
    tzs: String.t, # city only
    l: String.t,
    lat: String.t, # city only
    lon: String.t, # city only
    date: String.t, # hurricane only
    strmnum: String.t, # hurricane only
    basin: String.t, # hurricane only
    damage: String.t # hurricane only
  }
end
