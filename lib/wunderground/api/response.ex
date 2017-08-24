defmodule Wunderground.API.Response do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  alias Wunderground.API.Error

  @derive [Poison.Encoder]

  defstruct ~w(features termsofService version error)a

  @type error :: %{description: String.t, type: String.t}

  @typedoc """
  The Wunderground.API.Response struct.

  ## Example

      %Wunderground.API.Response{
        "features" => %{"forecast" => 1},
        "termsofService" => "http://www.wunderground.com/weather/api/d/terms.html",
        "version" => "0.1",
        "error" => %Wunderground.API.Error{
          "description" => "No cities match your search query",
          "type" => "querynotfound"
        }
      }

  """
  @type t :: %__MODULE__{
    features: map,
    termsofService: String.t,
    version: String.t,
    error: Error.t
  }
end
