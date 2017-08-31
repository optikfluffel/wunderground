defmodule Wunderground.Astronomy do
  @moduledoc """
  Handles API requests for getting the astronomy of a given place.
  """

  alias Wunderground.Query
  alias Wunderground.API
  alias Wunderground.Astronomy.Moonphase

  @derive [Poison.Encoder]

  defstruct ~w(response moon_phase)a

  @doc """
  Gets the current astronomy for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.astronomy/1` instead.*
  """
  @spec get(Query.t) :: {:ok, Moonphase.t} | {:error, API.error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    API.get_astronomy(query)
  end
end
