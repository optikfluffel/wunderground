defmodule Wunderground.Forecast.Result do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.Forecast.SimpleForecast
  alias Wunderground.Forecast.TXTForecast

  @derive [Poison.Encoder]

  defstruct ~w(simpleforecast txt_forecast)a

  @typedoc """
  The Wunderground.Forecast.Result struct.

  Contains `simpleforecast`, holding a `Wunderground.Forecast.SimpleForecast`,
  and `txt_forecast`, holding a `Wunderground.Forecast.TXTForecast`.

  ## Example

      %Wunderground.Forecast.Result{
        simpleforecast: %Wunderground.Forecast.SimpleForecast{},
        txt_forecast: %Wunderground.Forecast.TXTForecast{}
      }

  """
  @type t :: %__MODULE__{simpleforecast: SimpleForecast.t, txt_forecast: TXTForecast.t}
end
