defmodule Wunderground.API.ResponseBody do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(response forecast current_observation moon_phase almanac location)a

  @typedoc """
  The Wunderground.API.ResponseBody struct.

  ## TODO: Example
  """
  @type t :: %__MODULE__{
    response: Wunderground.API.Response.t,
    forecast: Wunderground.Forecast.t,
    current_observation: Wunderground.Conditions.t,
    moon_phase: Wunderground.Astronomy.t,
    almanac: Wunderground.Almanac.t,
    location: Wunderground.Geolookup.t
  }
end
