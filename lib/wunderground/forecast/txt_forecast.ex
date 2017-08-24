defmodule Wunderground.Forecast.TXTForecast do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.Forecast.TXTForecastDay

  @derive [Poison.Encoder]

  defstruct ~w(date forecastday)a

  @typedoc """
  The Wunderground.Forecast.TXTForecast struct consists of a `date`, which holds a String
  representation _of a Time_ (eg `1:23 PM CEST`) and a `forecastday` key,
  holding a list of `Wunderground.Forecast.TXTForecastDay` structs.

  ## Example

      %Wunderground.Forecast.TXTForecast{
        date: "7:20 PM PDT",
        forecastday: [
          %Wunderground.Forecast.TXTForecastDay{},
          %Wunderground.Forecast.TXTForecastDay{},
          %Wunderground.Forecast.TXTForecastDay{}
        ]
      }

  """
  @type t :: %__MODULE__{date: String.t, forecastday: list(TXTForecastDay.t)}
end
