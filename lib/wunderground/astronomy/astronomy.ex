defmodule Wunderground.Astronomy do
  @moduledoc """
  Handles API requests for getting the astronomy of a given place.
  """

  alias Wunderground.Query
  alias Wunderground.API
  alias Wunderground.Astronomy.Time

  @derive [Poison.Encoder]

  defstruct ~w(ageOfMoon current_time hemisphere moonrise moonset percentIlluminated phaseofMoon
               sunrise sunset)a

  @typedoc """
  The Wunderground.Astronomy struct.

  ## Example

      %Wunderground.Astronomy{
        ageOfMoon: "9",
        current_time: %Wunderground.Astronomy.Time{hour: "13", minute: "01"},
        hemisphere: "North",
        moonrise: %Wunderground.Astronomy.Time{hour: "16", minute: "37"},
        moonset: %Wunderground.Astronomy.Time{hour: "1", minute: "45"},
        percentIlluminated: "70",
        phaseofMoon: "Waxing Gibbous",
        sunrise: %Wunderground.Astronomy.Time{hour: "7", minute: "16"},
        sunset: %Wunderground.Astronomy.Time{hour: "20", minute: "25"}
      }

  """
  @type t :: %__MODULE__{
   ageOfMoon: String.t,
   current_time: Time.t,
   hemisphere: String.t,
   moonrise: Time.t,
   moonset: Time.t,
   percentIlluminated: String.t,
   phaseofMoon: String.t,
   sunrise: Time.t,
   sunset: Time.t
  }

  @doc """
  Gets the current astronomy for the given tuple.

  *Isn't really intended to be used directly. Use `Wunderground.astronomy/1` instead.*
  """
  @spec get(Query.t) :: {:ok, __MODULE__.t} | {:error, API.error}
  def get(query_args) do
    {:ok, query} = Query.build(query_args)
    API.get_astronomy(query)
  end
end
