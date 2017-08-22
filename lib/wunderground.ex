defmodule Wunderground do
  @moduledoc """
  Documentation for Wunderground.
  """

  alias Wunderground.CurrentConditions

  defdelegate current_conditions(query), to: CurrentConditions, as: :get
end
