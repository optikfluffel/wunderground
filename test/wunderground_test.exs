defmodule WundergroundTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Astronomy.Moonphase
  alias Wunderground.Conditions.Observation
  alias Wunderground.Forecast.Result

  setup_all do
    HTTPoison.start()
  end

  describe "conditions/1" do
    test "us" do
      use_cassette "conditions/us" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:us, "CA", "San_Francisco"})
      end
    end

    test "us_zip" do
      use_cassette "conditions/us_zip" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:us_zip, 60290})
      end
    end

    test "international" do
      use_cassette "conditions/international" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:international, "Australia", "Sydney"})
      end
    end

    test "geo" do
      use_cassette "conditions/geo" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:geo, 37.8, -122.4})
      end
    end

    test "airport" do
      use_cassette "conditions/airport" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:airport, "KJFK"})
      end
    end

    test "pws" do
      use_cassette "conditions/pws" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:pws, "KCASANFR70"})
      end
    end

    test "auto_ip" do
      use_cassette "conditions/auto_ip" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "conditions/auto_ip_custom" do
        assert {:ok, %Observation{}} = Wunderground.conditions({:auto_ip, {185, 1, 74, 1}})
      end
    end
  end

  describe "forecast/1" do
    test "us" do
      use_cassette "forecast/us" do
        assert {:ok, %Result{}} = Wunderground.forecast({:us, "CA", "San_Francisco"})
      end
    end

    test "us_zip" do
      use_cassette "forecast/us_zip" do
        assert {:ok, %Result{}} = Wunderground.forecast({:us_zip, 60290})
      end
    end

    test "international" do
      use_cassette "forecast/international" do
        assert {:ok, %Result{}} = Wunderground.forecast({:international, "Australia", "Sydney"})
      end
    end

    test "geo" do
      use_cassette "forecast/geo" do
        assert {:ok, %Result{}} = Wunderground.forecast({:geo, 37.8, -122.4})
      end
    end

    test "airport" do
      use_cassette "forecast/airport" do
        assert {:ok, %Result{}} = Wunderground.forecast({:airport, "KJFK"})
      end
    end

    test "pws" do
      use_cassette "forecast/pws" do
        assert {:ok, %Result{}} = Wunderground.forecast({:pws, "KCASANFR70"})
      end
    end

    test "auto_ip" do
      use_cassette "forecast/auto_ip" do
        assert {:ok, %Result{}} = Wunderground.forecast({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "forecast/auto_ip_custom" do
        assert {:ok, %Result{}} = Wunderground.forecast({:auto_ip, {185, 1, 74, 1}})
      end
    end
  end

  describe "astronomy/1" do
    test "us" do
      use_cassette "astronomy/us" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:us, "CA", "San_Francisco"})
      end
    end

    test "us_zip" do
      use_cassette "astronomy/us_zip" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:us_zip, 60290})
      end
    end

    test "international" do
      use_cassette "astronomy/international" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:international, "Australia", "Sydney"})
      end
    end

    test "geo" do
      use_cassette "astronomy/geo" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:geo, 37.8, -122.4})
      end
    end

    test "airport" do
      use_cassette "astronomy/airport" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:airport, "KJFK"})
      end
    end

    test "pws" do
      use_cassette "astronomy/pws" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:pws, "KCASANFR70"})
      end
    end

    test "auto_ip" do
      use_cassette "astronomy/auto_ip" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "astronomy/auto_ip_custom" do
        assert {:ok, %Moonphase{}} = Wunderground.astronomy({:auto_ip, {185, 1, 74, 1}})
      end
    end
  end
end
