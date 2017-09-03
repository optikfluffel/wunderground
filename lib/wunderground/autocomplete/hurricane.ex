defmodule Wunderground.Autocomplete.Hurricane do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(basin damage date l name strmnum)a

  @typedoc """
  The Wunderground.Autocomplete.Hurricane struct.

  ## Example

      %Wunderground.Autocomplete.Hurricane{
        basin: "at",
        damage: "0",
        date: "9/18/1993",
        l: "/hurricane/at19938.asp",
        name: "Harvey, Hurricane - Atlantic, 1993",
        strmnum: "8"
      }

  """
  @type t :: %__MODULE__{
    basin: String.t,
    damage: String.t,
    date: String.t,
    l: String.t,
    name: String.t,
    strmnum: String.t
  }
end
