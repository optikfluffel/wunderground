defmodule Wunderground.Almanac.Temperature do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.Almanac.TemperaturePair

  @derive [Poison.Encoder]

  defstruct ~w(normal record recordyear)a

  @typedoc """
  The Wunderground.Astronomy.Moonphase struct.

  ## Example

      %Wunderground.Astronomy.Temperature{
        normal: "16",
        record: "21",
        recordyear: "21"
      }

  """
  @type t :: %__MODULE__{
    normal: TemperaturePair.t,
    record: TemperaturePair.t,
    recordyear: String.t
  }
end
