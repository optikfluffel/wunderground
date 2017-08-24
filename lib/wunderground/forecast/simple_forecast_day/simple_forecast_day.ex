defmodule Wunderground.Forecast.SimpleForecastDay do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.Forecast.SimpleForecastDay.Wind
  alias Wunderground.Forecast.SimpleForecastDay.Date
  alias Wunderground.Forecast.SimpleForecastDay.Temperature
  alias Wunderground.Forecast.SimpleForecastDay.Rain
  alias Wunderground.Forecast.SimpleForecastDay.Snow

  @derive [Poison.Encoder]

  defstruct ~w(avehumidity avewind conditions date high icon icon_url low maxhumidity maxwind
               minhumidity period pop qpf_allday qpf_day qpf_night skyicon snow_allday
               snow_day snow_night)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecastDay struct.

  ## Example

      %Wunderground.Forecast.SimpleForecastDay{
        avehumidity: 64,
        avewind: %Wunderground.Forecast.SimpleForecastDay.Wind{
          degrees: 252,
          dir: "WSW",
          kph: 16,
          mph: 10
        },
        conditions: "Mostly Cloudy",
        date: %Wunderground.Forecast.SimpleForecastDay.Date{
          ampm: "PM",
          day: 24,
          epoch: "1503594000",
          hour: 19,
          isdst: "1",
          min: "00",
          month: 8,
          monthname: "August",
          monthname_short: "Aug",
          pretty: "7:00 PM CEST on August 24, 2017",
          sec: 0,
          tz_long: "Europe/Berlin",
          tz_short: "CEST",
          weekday: "Thursday",
          weekday_short: "Thu",
          yday: 235,
          year: 2017
        },
        high: %Wunderground.Forecast.SimpleForecastDay.Temperature{celsius: "23", fahrenheit: "73"},
        icon: "mostlycloudy",
        icon_url: "http://icons.wxug.com/i/c/k/mostlycloudy.gif",
        low: %Wunderground.Forecast.SimpleForecastDay.Temperature{celsius: "14", fahrenheit: "57"},
        maxhumidity: 0,
        maxwind: %Wunderground.Forecast.SimpleForecastDay.Wind{
          degrees: 252,
          dir: "WSW",
          kph: 24,
          mph: 15
        },
        minhumidity: 0,
        period: 1,
        pop: 10,
        qpf_allday: %Wunderground.Forecast.SimpleForecastDay.Rain{in: 0.0, mm: 0},
        qpf_day: %Wunderground.Forecast.SimpleForecastDay.Rain{in: 0.0, mm: 0},
        qpf_night: %Wunderground.Forecast.SimpleForecastDay.Rain{in: 0.0, mm: 0},
        skyicon: "",
        snow_allday: %Wunderground.Forecast.SimpleForecastDay.Snow{cm: 0.0, in: 0.0},
        snow_day: %Wunderground.Forecast.SimpleForecastDay.Snow{cm: 0.0, in: 0.0},
        snow_night: %Wunderground.Forecast.SimpleForecastDay.Snow{cm: 0.0, in: 0.0}
      }

  """
  @type t :: %__MODULE__{
    avehumidity: non_neg_integer,
    avewind: Wind.t,
    conditions: String.t,
    date: Date.t,
    high: Temperature.t,
    icon: String.t,
    icon_url: String.t,
    low: Temperature.t,
    maxhumidity: non_neg_integer,
    maxwind: Wind.t,
    minhumidity: non_neg_integer,
    period: pos_integer,
    pop: non_neg_integer,
    qpf_allday: Rain.t,
    qpf_day: Rain.t,
    qpf_night: Rain.t,
    skyicon: String.t,
    snow_allday: Snow.t,
    snow_day: Snow.t,
    snow_night: Snow.t
  }
end
