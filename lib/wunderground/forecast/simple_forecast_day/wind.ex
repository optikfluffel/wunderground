defmodule Wunderground.Forecast.SimpleForecastDay.Wind do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(degrees dir kph mph)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecastDay.Wind struct.

  ## Example

      %Wunderground.Forecast.SimpleForecastDay.Wind{
        degrees: 240,
        dir: "WSW",
        kph: 16,
        mph: 10
      }

  """
  @type t :: %__MODULE__{
    degrees: non_neg_integer,
    dir: String.t,
    kph: non_neg_integer,
    mph: non_neg_integer
  }
end
