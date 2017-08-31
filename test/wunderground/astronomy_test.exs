defmodule Wunderground.AstronomyTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Astronomy

  @not_found {:not_found, "No cities match your search query"}
  @station_offline {:station_offline, "The station you're looking for either doesn't exist or is simply offline right now."}

  describe "get/1" do
    test "us" do
      use_cassette "astronomy/us" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:us, "CA", "San_Francisco"})
      end
    end

    test "us not_found" do
      use_cassette "astronomy/us_not_found" do
        assert {:error, @not_found} = Astronomy.get({:us, "CA", "USDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "us_zip" do
      use_cassette "astronomy/us_zip" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:us_zip, 60290})
      end
    end

    test "us_zip not_found" do
      use_cassette "astronomy/us_zip_not_found" do
        assert {:error, @not_found} = Astronomy.get({:us_zip, -1})
      end
    end

    test "international" do
      use_cassette "astronomy/international" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:international, "Australia", "Sydney"})
      end
    end

    test "international not_found" do
      use_cassette "astronomy/international_not_found" do
        assert {:error, @not_found} = Astronomy.get({:international, "Australia", "AUDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "geo" do
      use_cassette "astronomy/geo" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:geo, 37.8, -122.4})
      end
    end

    test "geo not_found" do
      use_cassette "astronomy/geo_not_found" do
        assert {:error, @not_found} = Astronomy.get({:geo, 2500.0, -5000.0})
      end
    end

    test "airport" do
      use_cassette "astronomy/airport" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:airport, "KJFK"})
      end
    end

    test "airport not_found" do
      use_cassette "astronomy/airport_not_found" do
        assert {:error, @not_found} = Astronomy.get({:airport, "AIRUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "pws" do
      use_cassette "astronomy/pws" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:pws, "KCASANFR70"})
      end
    end

    test "pws not_found" do
      use_cassette "astronomy/pws_not_found" do
        assert {:error, @station_offline} = Astronomy.get({:pws, "NOT_A_PWS_ID"})
      end
    end

    test "auto_ip" do
      use_cassette "astronomy/auto_ip" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "astronomy/auto_ip_custom" do
        assert {:ok, %Astronomy{}} = Astronomy.get({:auto_ip, {185, 1, 74, 1}})
      end
    end

    test "auto_ip with 'wrong' ip address tuple" do
      assert_raise ArgumentError, fn ->
        Astronomy.get({:auto_ip, {"185", "1", "74", "1"}})
      end
    end

    test "auto_ip ArgumentError when no 4 element tuple is given" do
      assert_raise ArgumentError, fn ->
        Astronomy.get({:auto_ip, "185.1.74.1"})
      end
    end

    test "ArgumentError" do
      assert_raise ArgumentError, fn ->
        Astronomy.get(:not_an_argument)
      end
    end
  end
end
