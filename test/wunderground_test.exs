defmodule WundergroundTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Almanac
  alias Wunderground.Astronomy
  alias Wunderground.Conditions
  alias Wunderground.Forecast
  alias Wunderground.Geolookup

  test "conditions/1" do
    use_cassette "conditions/us" do
      assert {:ok, %Conditions{}} = Wunderground.conditions({:us, "CA", "San_Francisco"})
    end
  end

  test "forecast/1" do
    use_cassette "forecast/us_zip" do
      assert {:ok, %Forecast{}} = Wunderground.forecast({:us_zip, 60290})
    end
  end

  test "astronomy/1" do
    use_cassette "astronomy/international" do
      assert {:ok, %Astronomy{}} = Wunderground.astronomy({:international, "Australia", "Sydney"})
    end
  end

  test "almanac/1" do
    use_cassette "almanac/geo" do
      assert {:ok, %Almanac{}} = Wunderground.almanac({:geo, 37.8, -122.4})
    end
  end

  test "geolookup/1" do
    use_cassette "geolookup/airport" do
      assert {:ok, %Geolookup{}} = Wunderground.geolookup({:airport, "KJFK"})
    end
  end
end
