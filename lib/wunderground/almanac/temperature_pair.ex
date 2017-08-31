defmodule Wunderground.Almanac.TemperaturePair do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(F C)a

  @typedoc """
  The Wunderground.Astronomy.Moonphase struct.

  ## Example

      %Wunderground.Astronomy.Temperature{
        F: "16",
        C: "21"
      }

  """
  @type t :: %__MODULE__{
    F: String.t,
    C: String.t
  }
end
