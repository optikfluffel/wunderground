defmodule Wunderground.Forecast.SimpleForecast do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.Forecast.SimpleForecastDay

  @derive [Poison.Encoder]

  defstruct ~w(forecastday)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecast struct, holding a single `forecastday` key,
  which itself holds a list of `Wunderground.Forecast.SimpleForecastDay` structs.

  ## Example

      %Wunderground.Forecast.SimpleForecast{
        forecastday: [
          %Wunderground.Forecast.SimpleForecastDay{},
          %Wunderground.Forecast.SimpleForecastDay{},
          %Wunderground.Forecast.SimpleForecastDay{}
        ]
      }

  """
  @type t :: %__MODULE__{forecastday: list(SimpleForecastDay.t)}
end
