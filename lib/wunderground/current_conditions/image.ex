defmodule Wunderground.CurrentConditions.Image do
  @moduledoc """
  Ensures correct JSON encoding.
  """

  @derive [Poison.Encoder]

  defstruct ~w(url title link)a

  @typedoc """
  The Wunderground.CurrentConditions.Image struct.

  ## Example

      %Wunderground.CurrentConditions.Image{
        link: "http://www.wunderground.com",
        title: "Weather Underground",
        url: "http://icons.wxug.com/graphics/wu2/logo_130x80.png"
      }

  """
  @type t :: %__MODULE__{url: String.t, title: String.t, link: String.t}
end
