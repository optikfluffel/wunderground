defmodule Wunderground.Forecast do
  @moduledoc """
  Handles API requests for getting the forecast of a given place.
  """

  alias Wunderground.API
  alias Wunderground.Query
  alias Wunderground.Forecast.SimpleForecast
  alias Wunderground.Forecast.TXTForecast

  @derive [Poison.Encoder]
  defstruct ~w(simpleforecast txt_forecast)a

  @typedoc """
  The Wunderground.Forecast struct.

  ## Example

      %Wunderground.Forecast{
        simpleforecast: %Wunderground.Forecast.SimpleForecast{...},
        txt_forecast: %Wunderground.Forecast.TXTForecast{...}
      }
  """
  @type t :: %__MODULE__{
    simpleforecast: SimpleForecast.t,
    txt_forecast: TXTForecast.t
  }

  @doc """
  Gets the forecast for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.forecast/1` instead.*
  """
  @spec get(Query.t) :: {:ok, __MODULE__.t} | {:error, any}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    API.get_forecast(query)
  end
end
