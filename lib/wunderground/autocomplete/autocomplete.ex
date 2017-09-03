defmodule Wunderground.Autocomplete do
  @moduledoc """
  Handles API requests for autocompletion.
  """

  alias Wunderground.Autocomplete.API
  alias Wunderground.Autocomplete.City
  alias Wunderground.Autocomplete.Hurricane

  @derive [Poison.Encoder]

  defstruct ~w(cities hurricanes)a

  @type option :: :without_cities | :with_hurricanes | {:country, String.t}
  @type options :: list(option)

  @type t :: %__MODULE__{
    cities: list(City.t),
    hurricanes: list(Hurricane.t)
  }

  @spec get(String.t, options) :: {:ok, __MODULE__.t} | {:error, API.error}
  def get(query, options \\ []) do
    query_with_options = Enum.reduce(options, query, &add_option_to_query/2)
    API.get_autocomplete(query_with_options)
  end

  @spec add_option_to_query(option, String.t) :: String.t
  defp add_option_to_query(:without_cities, query), do: query <> "&cities=0"
  defp add_option_to_query(:with_hurricanes, query), do: query <> "&h=1"
  defp add_option_to_query({:country, country}, query), do: query <> "&c=" <> country
end
