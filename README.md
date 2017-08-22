# Wunderground

A basic wrapper for the [Weather Underground API](https://www.wunderground.com/weather/api/d/docs).

*Currently only suppors the [Stratus Plan](https://www.wunderground.com/weather/api/d/pricing.html) Endpoints.*
*With a Stratus Developer key, you get up to 10 API calls per minute and/or 500 calls per day (which is roughly one call every three minutes).*

## Installation

Add `wunderground` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    # ...
    {:wunderground, "~> 0.0.1"}
  ]
end
```

## Configuration

First go to [wunderground.com/weather/api](https://www.wunderground.com/weather/api/)
and sign up/in to get your API key.

By default, the `WUNDERGROUND_API_KEY` environment variable is checked for a key.

To set it explicitly you can put the following, in your config file(s):

```elixir
config :wunderground, api_key: "YOUR_API_KEY"
```

## Usage

### Current Conditions

```elixir
# For the US using {:us, state, city}
{:ok, conditions} = Wunderground.current_conditions({:us, "CA", "San_Francisco"})
# or using {:us_zip, zipcode}
{:ok, conditions} = Wunderground.current_conditions({:us_zip, 60290})

# International using {:international, country, city}
{:ok, conditions} = Wunderground.current_conditions({:international, "Australia", "Sydney"})

# Via coordinates using {:geo, lat, lng}
{:ok, conditions} = Wunderground.current_conditions({:geo, 37.8, -122.4})

# For an airport using {:airport, airport_code}
{:ok, conditions} = Wunderground.current_conditions({:airport, "KJFK"})

# For a specific personal weather station using {:pws, pws_id}
{:ok, conditions} = Wunderground.current_conditions({:pws, "KCASANFR70"})

# From the GeoIP of the running machine using {:auto_ip}
{:ok, conditions} = Wunderground.current_conditions({:auto_ip})
```

## TODO

-   [ ] Geolookup
-   [ ] Autocomplete
-   [ ] Current conditions
-   [ ] 3-day forecast summary
-   [ ] Astronomy
-   [ ] Almanac for today
