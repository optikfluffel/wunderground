defmodule Wunderground.CurrentConditions.CurrentObservation do
  @derive [Poison.Encoder]

  alias Wunderground.CurrentConditions.Image
  alias Wunderground.CurrentConditions.DisplayLocation
  alias Wunderground.CurrentConditions.ObservationLocation

  defstruct ~w(image display_location observation_location estimated station_id observation_time
               observation_time_rfc822 observation_epoch local_time_rfc822 local_epoch
               local_tz_short local_tz_long local_tz_offset weather temperature_string temp_f
               temp_c relative_humidity wind_string wind_dir wind_degrees wind_mph wind_gust_mph
               wind_kph wind_gust_kph pressure_mb pressure_in pressure_trend dewpoint_string
               dewpoint_f dewpoint_c heat_index_string heat_index_f heat_index_c windchill_string
               windchill_f windchill_c feelslike_string feelslike_f feelslike_c visibility_mi
               visibility_km solarradiation UV precip_1hr_string precip_1hr_in precip_1hr_metric
               precip_today_string precip_today_in precip_today_metric icon icon_url forecast_url
               history_url ob_url)a

  @typedoc """
  The Wunderground.CurrentConditions.CurrentObservation struct.

  ## Example

      %Wunderground.CurrentConditions.CurrentObservation{
        observation_time: "Last Updated on August 23, 7:57 PM CEST",
        pressure_in: "30.08",
        wind_kph: 1.0,
        precip_today_metric: "0",
        history_url: "http://www.wunderground.com/weatherstation/WXDailyHistory.asp?ID=IBEBERLI388",
        windchill_f: "NA",
        local_epoch: "1503511216",
        temp_c: 19.3,
        ob_url: "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=52.520008,13.404954",
        wind_degrees: 90,
        icon_url: "http://icons.wxug.com/i/c/k/clear.gif",
        pressure_trend: "0",
        feelslike_f: "66.7",
        precip_today_string: "0.00 in (0 mm)",
        display_location: %Wunderground.CurrentConditions.DisplayLocation{
          city: "Berlin",
          country: "DL",
          country_iso3166: "DE",
          elevation: "45.1",
          full: "Berlin,
          Germany",
          latitude: "52.52000046",
          longitude: "13.40999985",
          state: "BE",
          state_name: "Germany",
          zip: "00000"
        },
        wind_gust_mph: "1.2",
        local_tz_short: "CEST",
        precip_1hr_in: "-999.00",
        dewpoint_f: 60,
        windchill_string: "NA",
        image: %Wunderground.CurrentConditions.Image{
          link: "http://www.wunderground.com",
          title: "Weather Underground",
          url: "http://icons.wxug.com/graphics/wu2/logo_130x80.png"
        },
        local_time_rfc822: "Wed,
        23 Aug 2017 20:00:16 +0200",
        wind_string: "Calm",
        solarradiation: "--",
        wind_mph: 0.6,
        heat_index_string: "NA",
        temp_f: 66.7,
        forecast_url: "http://www.wunderground.com/global/stations/10389.html",
        icon: "clear",
        observation_time_rfc822: "Wed,
        23 Aug 2017 19:57:41 +0200",
        relative_humidity: "80%",
        precip_1hr_string: "-999.00 in ( 0 mm)",
        local_tz_long: "Europe/Berlin",
        temperature_string: "66.7 F (19.3 C)",
        dewpoint_c: 16,
        local_tz_offset: "+0200",
        pressure_mb: "1018.5",
        observation_epoch: "1503511061",
        precip_1hr_metric: " 0",
        precip_today_in: "0.00",
        feelslike_string: "66.7 F (19.3 C)",
        wind_dir: "East",
        UV: "0",
        wind_gust_kph: "1.9",
        station_id: "IBEBERLI388",
        dewpoint_string: "60 F (16 C)",
        observation_location: %Wunderground.CurrentConditions.ObservationLocation{
          city: "Berlin,
          Berlin Mitte",
          country: "DL",
          country_iso3166: "DE",
          elevation: "150 ft",
          full: "Berlin,
          Berlin Mitte,
          BE",
          latitude: "52.520008",
          longitude: "13.404954",
          state: "BE"
        },
        windchill_c: "NA",
        heat_index_f: "NA",
        feelslike_c: "19.3",
        estimated: %{},
        heat_index_c: "NA",
        visibility_km: "16",
        weather: "Clear",
        visibility_mi: "10"
      }

  """
  @type t :: %__MODULE__{
    image: Image.t,
    display_location: DisplayLocation.t,
    observation_location: ObservationLocation.t,
    estimated: any,
    station_id: String.t,
    observation_time: String.t,
    observation_time_rfc822: String.t,
    observation_epoch: String.t,
    local_time_rfc822: String.t,
    local_epoch: String.t,
    local_tz_short: String.t,
    local_tz_long: String.t,
    local_tz_offset: String.t,
    weather: String.t,
    temperature_string: String.t,
    temp_f: number,
    temp_c: number,
    relative_humidity: String.t,
    wind_string: String.t,
    wind_dir: String.t,
    wind_degrees: number,
    wind_mph: number,
    wind_gust_mph: number,
    wind_kph: number,
    wind_gust_kph: number,
    pressure_mb: String.t,
    pressure_in: String.t,
    pressure_trend: String.t,
    dewpoint_string: String.t,
    dewpoint_f: number,
    dewpoint_c: number,
    heat_index_string: String.t,
    heat_index_f: String.t,
    heat_index_c: String.t,
    windchill_string: String.t,
    windchill_f: String.t,
    windchill_c: String.t,
    feelslike_string: String.t,
    feelslike_f: String.t,
    feelslike_c: String.t,
    visibility_mi: String.t,
    visibility_km: String.t,
    solarradiation: String.t,
    UV: String.t,
    precip_1hr_string: String.t,
    precip_1hr_in: String.t,
    precip_1hr_metric: String.t,
    precip_today_string: String.t,
    precip_today_in: String.t,
    precip_today_metric: String.t,
    icon: String.t,
    icon_url: String.t,
    forecast_url: String.t,
    history_url: String.t,
    ob_url: String.t
  }
end
