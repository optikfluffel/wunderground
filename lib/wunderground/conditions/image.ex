defmodule Wunderground.CurrentConditions.Image do
  @derive [Poison.Encoder]

  defstruct ~w(url title link)a

  @type t :: %__MODULE__{url: String.t, title: String.t, link: String.t}
end
