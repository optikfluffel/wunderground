defmodule Wunderground.CurrentConditions do
  alias Wunderground.Query
  alias Wunderground.API

  require Logger

  @type error_type :: :not_found | :station_offline | String.t
  @type error_message :: String.t
  @type error :: {error_type, error_message}

  @doc """
  Gets the current conditions for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.current_conditions/1` instead.*
  """
  @spec get(Query.t) :: {:ok, any} | {:error, any}
  def get({:us, state, city}) do
    get_from_api(state <> "/" <> city)
  end
  def get({:us_zip, zipcode}) do
    zipcode
    |> Integer.to_string()
    |> get_from_api()
  end
  def get({:international, country, city}) do
    get_from_api(country <> "/" <> city)
  end
  def get({:geo, lat, lng}) do
    query_string = Float.to_string(lat) <> "," <> Float.to_string(lng)
    get_from_api(query_string)
  end
  def get({:airport, airport_code}) do
    get_from_api(airport_code)
  end
  def get({:pws, pws_id}) do
    get_from_api("pws:" <> pws_id)
  end
  def get({:auto_ip}) do
    get_from_api("auto_ip")
  end
  # TODO: support auto_ip with specific IP address
  # def get({:auto_ip, {a, b, c, d}}) do
  #   get_from_api()
  # end
  def get(_) do
    msg = """
    Invalid argument for Wunderground.CurrentConditions.get/1

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

  # ---------------------------------------- PRIVATE HELPER
  @spec get_from_api(String.t) :: {:ok, map} | {:error, error}
  defp get_from_api(query_string) do
    case API.get("/conditions/q/" <> query_string) do
      {:ok, response} ->
        decode_body(response.body)

      {:error, error} ->
        Logger.warn "Error while trying to get current conditions with query: #{query_string}"
        Logger.warn inspect(error)
        {:error, error}
    end
  end

  @spec decode_body(String.t) :: {:ok, map} | {:error, any}
  defp decode_body(body) do
    decoded = Poison.decode!(body)

    case decoded["response"]["error"] do
      %{"description" => description, "type" => "querynotfound"} ->
        {:error, {:not_found, description}}

      %{"description" => description, "type" => error_type} ->
        Logger.warn "Unhandled error: " <> error_type
        Logger.warn "with description: " <> description
        {:error, {error_type, description}}

      %{"type" => "Station:OFFLINE"} ->
        msg = "The station you're looking for either doesn't exist or is simply offline right now."
        {:error, {:station_offline, msg}}

      %{"type" => error_type} ->
        Logger.warn "Unhandled error: " <> error_type
        {:error, {error_type, "No description."}}

      _ ->
        {:ok, decoded["current_observation"]}
    end
  end
end
