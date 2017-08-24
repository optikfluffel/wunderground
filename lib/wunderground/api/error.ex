defmodule Wunderground.API.Error do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(description type)a

  @typedoc """
  The Wunderground.API.Error struct.

  ## Example

      %Wunderground.API.Error{
        description: "No cities match your search query",
        type: "querynotfound"
      }

  """
  @type t :: %__MODULE__{
    description: String.t,
    type: String.t
  }
end
