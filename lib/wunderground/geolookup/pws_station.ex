defmodule Wunderground.Geolookup.PWSStation do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(neighborhood city state country id distance_km distance_mi)a

  @typedoc """
  The Wunderground.Geolookup.PWSStation struct.

  ## Example

      %Wunderground.Geolookup.PWSStation{
        city: "Omori",
        country: "JP",
        distance_km: 4,
        distance_mi: 2,
        id: "I13OMORI2",
        neighborhood: "Tokyo",
        state: "13"
      }

  """
  @type t :: %__MODULE__{
    neighborhood: String.t,
    city: String.t,
    state: String.t,
    country: String.t,
    id: String.t,
    distance_km: String.t,
    distance_mi: String.t
  }
end
