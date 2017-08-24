defmodule Wunderground.Conditions do
  @moduledoc """
  Handles API requests for getting the current conditions of a given place.
  """

  alias Wunderground.Query
  alias Wunderground.API
  alias Wunderground.Conditions.Observation
  alias Wunderground.Conditions.Image
  alias Wunderground.Conditions.DisplayLocation
  alias Wunderground.Conditions.ObservationLocation

  require Logger

  @derive [Poison.Encoder]

  defstruct ~w(response current_observation)a

  @type error_type :: :invalid_api_key | :not_found | :station_offline | String.t
  @type error_message :: String.t
  @type error :: {error_type, error_message}

  @doc """
  Gets the current conditions for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.conditions/1` instead.*
  """
  @spec get(Query.t) :: {:ok, Observation.t} | {:error, error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    get_from_api(query)
  end

  # ---------------------------------------- PRIVATE HELPER
  @spec get_from_api(String.t) :: {:ok, Observation.t} | {:error, error}
  defp get_from_api(query_string) do
    case API.get("/conditions" <> query_string) do
      {:ok, response} ->
        decode_body(response.body)

      {:error, error} ->
        Logger.warn "Error while trying to get current conditions with query: #{query_string}"
        Logger.warn inspect(error)
        {:error, error}
    end
  end

  @spec decode_body(String.t) :: {:ok, Observation.t} | {:error, error}
  defp decode_body(body) do
    decoded = Poison.decode!(body, as: %Wunderground.Conditions{
      response: %Wunderground.API.Response{
        error: %Wunderground.API.Error{}
      },
      current_observation: %Observation{
        image: %Image{},
        display_location: %DisplayLocation{},
        observation_location: %ObservationLocation{}
      }
    })

    case decoded.response.error do
      %Wunderground.API.Error{description: description, type: "querynotfound"} ->
        {:error, {:not_found, description}}

      # TODO: handle elsewhere, maybe this whole function should go to Query or API
      %Wunderground.API.Error{description: description, type: "keynotfound"} ->
        {:error, {:invalid_api_key, description}}

      %Wunderground.API.Error{type: "Station:OFFLINE"} ->
        msg = "The station you're looking for either doesn't exist or is simply offline right now."
        {:error, {:station_offline, msg}}

      %Wunderground.API.Error{description: description, type: error_type} ->
        Logger.warn "Unhandled error: " <> error_type
        Logger.warn "with description: " <> description
        {:error, {error_type, description}}

      _ ->
        {:ok, decoded.current_observation}
    end
  end
end
