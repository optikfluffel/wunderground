defmodule Wunderground.AutocompleteTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Autocomplete
  alias Wunderground.Autocomplete.City
  alias Wunderground.Autocomplete.Hurricane

  test "default" do
    use_cassette "autocomplete/city" do
      assert {:ok, %Autocomplete{} = autocomplete} = Autocomplete.get("San Fra")

      assert length(autocomplete.cities) > 0
      assert %City{} = List.first(autocomplete.cities)
    end
  end

  test "filter by country" do
    use_cassette "autocomplete/filter_by_country" do
      assert {:ok, %Autocomplete{} = autocomplete} = Autocomplete.get("Fra", [{:country, "DE"}])

      assert length(autocomplete.cities) > 0
      assert %City{c: "DE"} = List.first(autocomplete.cities)
    end
  end

  test "with_hurricanes" do
    use_cassette "autocomplete/with_hurricanes" do
      assert {:ok, %Autocomplete{} = autocomplete} = Autocomplete.get("Arlen", [:with_hurricanes])

      assert length(autocomplete.cities) > 0
      assert %City{} = List.first(autocomplete.cities)

      assert length(autocomplete.hurricanes) > 0
      assert %Hurricane{} = List.first(autocomplete.hurricanes)
    end
  end

  test "with_hurricanes and without_cities" do
    use_cassette "autocomplete/with_hurricanes_without_cities" do
      opts = [:with_hurricanes, :without_cities]
      assert {:ok, %Autocomplete{} = autocomplete} = Autocomplete.get("Harvey", opts)

      assert is_nil(autocomplete.cities)

      assert length(autocomplete.hurricanes) > 0
      assert %Hurricane{} = List.first(autocomplete.hurricanes)
    end
  end
end
