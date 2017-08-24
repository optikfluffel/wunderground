defmodule Wunderground.Forecast.SimpleForecastDay.Temperature do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(celsius fahrenheit)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecastDay.Temperature struct.

  ## Example

      %Wunderground.Forecast.SimpleForecastDay.Temperature{
        celsius: "23",
        fahrenheit: "74"
      }

  """
  @type t :: %__MODULE__{
    celsius: String.t,
    fahrenheit: String.t
  }
end
