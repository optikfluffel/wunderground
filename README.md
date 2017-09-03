# Wunderground

[![Wunderground](https://icons.wxug.com/logos/PNG/wundergroundLogo_4c_horz.png)](https://www.wunderground.com)

A basic wrapper for the [Weather Underground API](https://www.wunderground.com/weather/api/d/docs).

*Currently only supports the [Stratus Plan](https://www.wunderground.com/weather/api/d/pricing.html) Endpoints. With a Stratus Developer key, you get up to 10 API calls per minute and/or 500 calls per day (which is roughly one call every three minutes).*

[![Build Status](https://travis-ci.org/optikfluffel/wunderground.svg?branch=master)](https://travis-ci.org/optikfluffel/wunderground)
[![Coveralls](https://img.shields.io/coveralls/optikfluffel/wunderground.svg)](https://coveralls.io/github/optikfluffel/wunderground)
[![Inline docs](http://inch-ci.org/github/optikfluffel/wunderground.svg)](https://hexdocs.pm/wunderground)
[![Version](http://img.shields.io/hexpm/v/wunderground.svg?style=flat)](https://hex.pm/packages/wunderground)
[![License](https://img.shields.io/hexpm/l/wunderground.svg?style=flat)](https://unlicense.org)

## 📦 Installation

Add `wunderground` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    # ...
    {:wunderground, "~> 0.0.8"}
  ]
end
```

## 🔧 Configuration

First go to [wunderground.com/weather/api](https://www.wunderground.com/weather/api/)
and sign up/in to get your API key.

The prefered way is to add an environment variable:

```sh
export WUNDERGROUND_API_KEY="<<YOUR KEY HERE>>"
```

And then load it in your `config.exs` (or env specific configuration file) like so:

```elixir
config :wunderground, api_key: System.get_env("WUNDERGROUND_API_KEY")
```

## Usage

### 🗓 Almanac

```elixir
query = {:us_zip, 11204}
{:ok, almanac} = Wunderground.almanac(query)
```

### 🌖 Astronomy

```elixir
query = {:airport, "LEBL"}
{:ok, astronomy} = Wunderground.astronomy(query)
```

### 🌤 Current Conditions

```elixir
query = {:us, "CA", "San_Francisco"}
{:ok, conditions} = Wunderground.conditions(query)
```

### 📅 Forecast

```elixir
query = {:pws, "KCASANFR70"}
{:ok, forecast} = Wunderground.forecast(query)
```

### 🗺 Geolookup

```elixir
query = {:international, "Germany", "Berlin"}
{:ok, geolookup} = Wunderground.geolookup(query)
```

## Different Queries

🇺🇸 Cities in the U.S.
```elixir
# using state and city
{:us, "CA", "San_Francisco"}

# or via zipcode
{:us_zip, 60290}
```

🌍 Cities outside the U.S.
```elixir
# by country and city
{:international, "Australia", "Sydney"}
```

🌐 Coordinates
```elixir
# by latidute and longitude
{:geo, 37.8, -122.4}
```

✈️ Airports
```elixir
# by International Civil Aviation Organization airport code
# see https://en.wikipedia.org/wiki/International_Civil_Aviation_Organization_airport_code
{:airport, "KJFK"}
```

🌡 Specific personal weather station
```elixir
# by it's ID
{:pws, "KCASANFR70"}
```

📍 GeoIP location
```elixir
# of the running machine using
{:auto_ip}

# or of a specific IP address
{:auto_ip, {185, 1, 74, 1}}
```

### 🔎 Autocomplete

```elixir
# autocomplete suggestions for the given search query
{:ok, autocomplete} = Wunderground.autocomplete("San Fra")
```

## ☑️ TODOs

-   [x] Geolookup
-   [ ] Autocomplete
-   [x] Current conditions
-   [x] 3-day forecast summary
-   [x] Astronomy
-   [x] Almanac for today

---

*Weather Underground is a registered trademark of The Weather Channel, LLC. both in the United States and internationally. The Weather Underground Logo is a trademark of Weather Underground, LLC.*
