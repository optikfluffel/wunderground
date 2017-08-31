defmodule Wunderground.GeolookupTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Geolookup

  @not_found {:not_found, "No cities match your search query"}
  @station_offline {:station_offline, "The station you're looking for either doesn't exist or is simply offline right now."}

  describe "get/1" do
    test "us" do
      use_cassette "geolookup/us" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:us, "CA", "San_Francisco"})
      end
    end

    test "us not_found" do
      use_cassette "geolookup/us_not_found" do
        assert {:error, @not_found} = Geolookup.get({:us, "CA", "USDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "us_zip" do
      use_cassette "geolookup/us_zip" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:us_zip, 60290})
      end
    end

    test "us_zip not_found" do
      use_cassette "geolookup/us_zip_not_found" do
        assert {:error, @not_found} = Geolookup.get({:us_zip, -1})
      end
    end

    test "international" do
      use_cassette "geolookup/international" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:international, "Australia", "Sydney"})
      end
    end

    test "international not_found" do
      use_cassette "geolookup/international_not_found" do
        assert {:error, @not_found} = Geolookup.get({:international, "Australia", "AUDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "geo" do
      use_cassette "geolookup/geo" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:geo, 37.8, -122.4})
      end
    end

    test "geo not_found" do
      use_cassette "geolookup/geo_not_found" do
        assert {:error, @not_found} = Geolookup.get({:geo, 2500.0, -5000.0})
      end
    end

    test "airport" do
      use_cassette "geolookup/airport" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:airport, "KJFK"})
      end
    end

    test "airport not_found" do
      use_cassette "geolookup/airport_not_found" do
        assert {:error, @not_found} = Geolookup.get({:airport, "AIRUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "pws" do
      use_cassette "geolookup/pws" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:pws, "KCASANFR70"})
      end
    end

    test "pws not_found" do
      use_cassette "geolookup/pws_not_found" do
        assert {:error, @station_offline} = Geolookup.get({:pws, "NOT_A_PWS_ID"})
      end
    end

    test "auto_ip" do
      use_cassette "geolookup/auto_ip" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "geolookup/auto_ip_custom" do
        assert {:ok, %Geolookup{}} = Geolookup.get({:auto_ip, {185, 1, 74, 1}})
      end
    end

    test "auto_ip with 'wrong' ip address tuple" do
      assert_raise ArgumentError, fn ->
        Geolookup.get({:auto_ip, {"185", "1", "74", "1"}})
      end
    end

    test "auto_ip ArgumentError when no 4 element tuple is given" do
      assert_raise ArgumentError, fn ->
        Geolookup.get({:auto_ip, "185.1.74.1"})
      end
    end

    test "ArgumentError" do
      assert_raise ArgumentError, fn ->
        Geolookup.get(:not_an_argument)
      end
    end
  end
end
