defmodule Wunderground.Query do
  @moduledoc """
  A collections of types for handling queries to the Weather Underground API.

  ## List of possible queries

  🇺🇸 Cities in the U.S.

      # using state and city
      {:us, "CA", "San_Francisco"}

      # or via zipcode
      {:us_zip, 60290}


  🌍 Cities outside the U.S.

      # by country and city
      {:international, "Australia", "Sydney"}


  🌐 Coordinates

      # by latidute and longitude
      {:geo, 37.8, -122.4}


  ✈️ Airports

      # by International Civil Aviation Organization airport code
      # see https://en.wikipedia.org/wiki/International_Civil_Aviation_Organization_airport_code
      {:airport, "KJFK"}


  🌡 Specific personal weather station

      # by it's ID
      {:pws, "KCASANFR70"}


  📍 GeoIP location

      # of the running machine using
      {:auto_ip}

      # or of a specific IP address
      {:auto_ip, {185, 1, 74, 1}}

  """

  @invalid_ip """
  Invalid argument for Wunderground.Conditions.get({:auto_ip, ip})

    The given ip address should be a tuple with four integers, eg:

    {127, 0, 0, 1}
  """

  @typedoc """
  US state shortform.

  ## Example

      state = "CA" # for California

  """
  @type state :: String.t

  @typedoc """
  City name as a String, where spaces should be replaced by a `_`.

  ## Example

      city = "San_Francisco"

  """
  @type city :: String.t

  @typedoc """
  US zipcode as an Integer.

  ## Example

      zipcode = 60290 # for Chicago, Illinois

  """
  @type zipcode :: non_neg_integer

  @typedoc """
  Country as a String.

  ## Example

      country = "Australia"

  """
  @type country :: String.t

  @typedoc """
  Latitude as a float.

  ## Example

      lat = 37.8

  """
  @type lat :: float

  @typedoc """
  Longitude as a float.

  ## Example

      lng = -122.4

  """
  @type lng :: float

  @typedoc """
  Shortcode of an airport.
  See [International Civil Aviation Organization airport code](https://en.wikipedia.org/wiki/International_Civil_Aviation_Organization_airport_code).

  ## Example

      airport_code = "KJFK" # for the John F. Kennedy International Airport

  """
  @type airport_code :: String.t

  @typedoc """
  An ID of a personal weather station as a string.

  ## Example

      pws_id = "KCASANFR70"

  """
  @type pws_id :: String.t

  @typedoc """
  An IPv4 address as a tuple of 4 integers.

  ## Example

      ipv4_address = {10, 0, 0, 23} # for 10.0.0.23

  """
  @type ipv4_address :: {non_neg_integer, non_neg_integer, non_neg_integer, non_neg_integer}

  @typedoc """
  The different possible Query tuples.
  """
  @type t :: {:us, state, city} |
             {:us_zip, zipcode} |
             {:international, country, city} |
             {:geo, lat, lng} |
             {:airport, airport_code} |
             {:pws, pws_id} |
             {:auto_ip} |
             {:auto_ip, ipv4_address}

  @doc """
  Builds a query string for the given `Query` tuple.

  *Isn't really intended to be used directly. Use `Wunderground.forecast/1` instead.*
  """
  @spec build(__MODULE__.t) :: {:ok, String.t}
  def build({:us, state, city}) do
    query(state <> "/" <> city)
  end
  def build({:us_zip, zipcode}) do
    query(Integer.to_string(zipcode))
  end
  def build({:international, country, city}) do
    query(country <> "/" <> city)
  end
  def build({:geo, lat, lng}) do
    query(Float.to_string(lat) <> "," <> Float.to_string(lng))
  end
  def build({:airport, airport_code}) do
    query(airport_code)
  end
  def build({:pws, pws_id}) do
    query("pws:" <> pws_id)
  end
  def build({:auto_ip}) do
    query("auto_ip")
  end
  def build({:auto_ip, {_, _, _, _} = ip}) do
    case :inet_parse.ntoa(ip) do
      {:error, _reason} ->
        raise ArgumentError, message: @invalid_ip

      ip_charlist when is_list(ip_charlist) ->
        query("auto_ip", "?geo_ip=#{to_string ip_charlist}")
    end
  end
  def build({:auto_ip, _}) do
    raise ArgumentError, message: @invalid_ip
  end
  def build(_) do
    msg = """
    Invalid argument for Wunderground.Conditions.build/1

      The given argument should be one of:

      - {:us, state, city}
      - {:us_zip, zipcode}
      - {:international, country, city}
      - {:geo, lat, lng}
      - {:airport, airport_code}
      - {:pws, pws_id}
      - {:auto_ip}
    """
    raise ArgumentError, message: msg
  end

  defp query(path, params \\ "") do
    {:ok, "/q/" <> path <> ".json" <> params}
  end
end
