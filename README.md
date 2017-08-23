# Wunderground

A basic wrapper for the [Weather Underground API](https://www.wunderground.com/weather/api/d/docs).

*Currently only suppors the [Stratus Plan](https://www.wunderground.com/weather/api/d/pricing.html) Endpoints.*
*With a Stratus Developer key, you get up to 10 API calls per minute and/or 500 calls per day (which is roughly one call every three minutes).*

[![Build Status](https://travis-ci.org/optikfluffel/wunderground.svg?branch=master)](https://travis-ci.org/optikfluffel/wunderground)
[![Coveralls](https://img.shields.io/coveralls/optikfluffel/wunderground.svg)](https://coveralls.io/github/optikfluffel/wunderground)
[![Inline docs](http://inch-ci.org/github/optikfluffel/wunderground.svg)](http://inch-ci.org/github/optikfluffel/wunderground)
[![Version](http://img.shields.io/hexpm/v/wunderground.svg?style=flat)](https://hex.pm/packages/wunderground)
[![License](https://img.shields.io/hexpm/l/wunderground.svg?style=flat)](https://unlicense.org)

## Installation

Add `wunderground` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    # ...
    {:wunderground, "~> 0.0.2"}
  ]
end
```

## Configuration

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

### Current Conditions

```elixir
# For the US using {:us, state, city} or {:us_zip, zipcode}
{:ok, conditions} = Wunderground.conditions({:us, "CA", "San_Francisco"})
{:ok, conditions} = Wunderground.conditions({:us_zip, 60290})

# International using {:international, country, city}
{:ok, conditions} = Wunderground.conditions({:international, "Australia", "Sydney"})

# Via coordinates using {:geo, lat, lng}
{:ok, conditions} = Wunderground.conditions({:geo, 37.8, -122.4})

# For an airport using {:airport, airport_code}
{:ok, conditions} = Wunderground.conditions({:airport, "KJFK"})

# For a specific personal weather station using {:pws, pws_id}
{:ok, conditions} = Wunderground.conditions({:pws, "KCASANFR70"})

# From the GeoIP of the running machine using {:auto_ip}
{:ok, conditions} = Wunderground.conditions({:auto_ip})
```

## TODO

-   [ ] Geolookup
-   [ ] Autocomplete
-   [ ] Current conditions
-   [ ] 3-day forecast summary
-   [ ] Astronomy
-   [ ] Almanac for today
