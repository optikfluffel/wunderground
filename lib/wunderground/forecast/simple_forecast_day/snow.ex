defmodule Wunderground.Forecast.SimpleForecastDay.Snow do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(in cm)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecastDay.Snow struct.

  ## Example

      %Wunderground.Forecast.SimpleForecastDay.Snow{
        in: 0.0,
        cm: 0.0
      }

  """
  @type t :: %__MODULE__{
    in: float,
    cm: float
  }
end
