defmodule Wunderground.Autocomplete.Response do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(RESULTS)a

  @type t :: %__MODULE__{RESULTS: list(Wunderground.Autocomplete.Result.t)}
end
