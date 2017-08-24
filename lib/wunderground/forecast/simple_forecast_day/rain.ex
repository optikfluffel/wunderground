defmodule Wunderground.Forecast.SimpleForecastDay.Rain do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(in mm)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecastDay.Rain struct.

  ## Example

      %Wunderground.Forecast.SimpleForecastDay.Rain{
        in: 0.0,
        mm: 0
      }

  """
  @type t :: %__MODULE__{
    in: float,
    mm: non_neg_integer
  }
end
