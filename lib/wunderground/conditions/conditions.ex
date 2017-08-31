defmodule Wunderground.Conditions do
  @moduledoc """
  Handles API requests for getting the current conditions of a given place.
  """

  alias Wunderground.Query
  alias Wunderground.API
  alias Wunderground.Conditions.Observation

  @doc """
  Gets the current conditions for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.conditions/1` instead.*
  """
  @spec get(Query.t) :: {:ok, Observation.t} | {:error, API.error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    API.get_conditions(query)
  end
end
