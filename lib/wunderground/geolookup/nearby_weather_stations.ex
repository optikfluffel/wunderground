defmodule Wunderground.Geolookup.NearbyWeatherStations do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.Geolookup.AirportStation
  alias Wunderground.Geolookup.PWSStation
  alias Wunderground.Geolookup.StationWrapper

  @derive [Poison.Encoder]

  defstruct ~w(pws airport)a

  @typedoc """
  The Wunderground.Geolookup.NearbyWeatherStations struct.

  ## Example

      %Wunderground.Geolookup.NearbyWeatherStations{
        pws: %StationWrapper{station: []}, # list of PWSStation
        airport: %StationWrapper{station: []} # list of AirportStation
      }

  """
  @type t :: %__MODULE__{
    pws: %StationWrapper{station: list(PWSStation.t)},
    airport: %StationWrapper{station: list(AirportStation.t)}
  }
end
