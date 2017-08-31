defmodule Wunderground.Geolookup.StationWrapper do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(station)a

  @typedoc """
  The Wunderground.Geolookup.StationWrapper struct.

  ## Example

      %Wunderground.Geolookup.StationWrapper{
        station: []
      }

  """
  @type t :: %__MODULE__{
    station: list(PWSStation.t) | list(AirportStation.t)
  }
end
