defmodule Wunderground.Query do
  @moduledoc """
  A collections of types for handling queries to the Weather Underground API.
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
             {:auto_ip} # TODO: | {:auto_ip, ipv4_address}
end
