defmodule Wunderground.Forecast.SimpleForecastDay.Date do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(ampm day epoch hour isdst min month monthname monthname_short
               pretty sec tz_long tz_short weekday weekday_short yday year)a

  @typedoc """
  The Wunderground.Forecast.SimpleForecastDay.Date struct.

  ## Example

      %Wunderground.Forecast.SimpleForecastDay.Date{
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
      }

  """
  @type t :: %__MODULE__{
    ampm: String.t,
    day: pos_integer,
    epoch: String.t,
    hour: non_neg_integer,
    isdst: String.t,
    min: String.t,
    month: pos_integer,
    monthname: String.t,
    monthname_short: String.t,
    pretty: String.t,
    sec: non_neg_integer,
    tz_long: String.t,
    tz_short: String.t,
    weekday: String.t,
    weekday_short: String.t,
    yday: pos_integer,
    year: integer
  }
end
