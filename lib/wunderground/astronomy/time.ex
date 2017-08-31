defmodule Wunderground.Astronomy.Time do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(hour minute)a

  @typedoc """
  The Wunderground.Astronomy.Time struct.

  ## Example

      %Wunderground.Astronomy.Time{
        hour: "16",
        minute: "21"
      }

  """
  @type t :: %__MODULE__{
    hour: String.t,
    minute: String.t
  }
end
