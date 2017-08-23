defmodule WundergroundTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.CurrentConditions.CurrentObservation

  setup_all do
    HTTPoison.start()
  end

  describe "current_conditions/1" do
    test "us" do
      use_cassette "current_conditions/us" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:us, "CA", "San_Francisco"})
      end
    end

    test "us_zip" do
      use_cassette "current_conditions/us_zip" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:us_zip, 60290})
      end
    end

    test "international" do
      use_cassette "current_conditions/international" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:international, "Australia", "Sydney"})
      end
    end

    test "geo" do
      use_cassette "current_conditions/geo" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:geo, 37.8, -122.4})
      end
    end

    test "airport" do
      use_cassette "current_conditions/airport" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:airport, "KJFK"})
      end
    end

    test "pws" do
      use_cassette "current_conditions/pws" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:pws, "KCASANFR70"})
      end
    end

    test "auto_ip" do
      use_cassette "current_conditions/auto_ip" do
        assert {:ok, %CurrentObservation{}} = Wunderground.current_conditions({:auto_ip})
      end
    end
  end
end
