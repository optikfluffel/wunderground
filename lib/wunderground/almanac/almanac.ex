defmodule Wunderground.Almanac do
  @moduledoc """
  Handles API requests for getting the almanac of a given place.
  """

  alias Wunderground.Query
  alias Wunderground.API
  alias Wunderground.Almanac.Temperature

  @derive [Poison.Encoder]

  defstruct ~w(airport_code temp_high temp_low)a

  @type t :: %__MODULE__{
    airport_code: String.t,
    temp_high: Temperature.t,
    temp_low: Temperature.t
  }

  @doc """
  Gets the current almanac for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.almanac/1` instead.*
  """
  @spec get(Query.t) :: {:ok, __MODULE__.t} | {:error, API.error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    API.get_almanac(query)
  end
end
