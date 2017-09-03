defmodule Wunderground.AutocompleteTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Autocomplete

  test "city" do
    use_cassette "autocomplete/city" do
      assert {:ok, %Autocomplete{} = autocomplete} = Autocomplete.get("San Fra")
      assert length(autocomplete.cities) > 0
    end
  end
end
