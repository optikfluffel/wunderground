defmodule Wunderground.Autocomplete do
  @moduledoc """
  Handles API requests for autocompletion.
  """

  alias Wunderground.Autocomplete.API

  @derive [Poison.Encoder]

  defstruct ~w(cities hurricanes)a

  @type t :: %__MODULE__{
    cities: list(Wunderground.Autocomplete.Result.t),
    hurricanes: list(Wunderground.Autocomplete.Result.t)
  }

  @spec get(String.t) :: {:ok, __MODULE__.t} | {:error, API.error}
  def get(query), do: API.get_autocomplete(query)
end
