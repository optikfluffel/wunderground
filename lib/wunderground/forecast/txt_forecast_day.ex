defmodule Wunderground.Forecast.TXTForecastDay do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(fcttext fcttext_metric icon icon_url period pop title)a

  @typedoc """
  The Wunderground.Forecast.TXTForecastDay struct.

  ## Example

      %Wunderground.Forecast.TXTForecastDay{
        fcttext: "Considerable cloudiness. High 73F. Winds WSW at 10 to 15 mph.",
        fcttext_metric: "A mix of clouds and sun. High 23C. Winds WSW at 15 to 25 km/h.",
        icon: "mostlycloudy",
        icon_url: "http://icons.wxug.com/i/c/k/mostlycloudy.gif",
        period: 0,
        pop: "10",
        title: "Thursday"
      }

  """
  @type t :: %__MODULE__{
    fcttext: String.t,
    fcttext_metric: String.t,
    icon: String.t,
    icon_url: String.t,
    period: non_neg_integer,
    pop: String.t,
    title: String.t
  }
end
