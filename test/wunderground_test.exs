defmodule WundergroundTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Conditions.CurrentObservation

  setup_all do
    HTTPoison.start()
  end

  describe "conditions/1" do
    test "us" do
      use_cassette "conditions/us" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:us, "CA", "San_Francisco"})
      end
    end

    test "us_zip" do
      use_cassette "conditions/us_zip" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:us_zip, 60290})
      end
    end

    test "international" do
      use_cassette "conditions/international" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:international, "Australia", "Sydney"})
      end
    end

    test "geo" do
      use_cassette "conditions/geo" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:geo, 37.8, -122.4})
      end
    end

    test "airport" do
      use_cassette "conditions/airport" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:airport, "KJFK"})
      end
    end

    test "pws" do
      use_cassette "conditions/pws" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:pws, "KCASANFR70"})
      end
    end

    test "auto_ip" do
      use_cassette "conditions/auto_ip" do
        assert {:ok, %CurrentObservation{}} = Wunderground.conditions({:auto_ip})
      end
    end
  end
end
