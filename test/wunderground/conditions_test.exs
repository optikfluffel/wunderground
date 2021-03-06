defmodule Wunderground.ConditionsTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Conditions

  @not_found {:not_found, "No cities match your search query"}
  @station_offline {:station_offline, "The station you're looking for either doesn't exist or is simply offline right now."}

  describe "get/1" do
    test "us" do
      use_cassette "conditions/us" do
        assert {:ok, %Conditions{}} = Conditions.get({:us, "CA", "San_Francisco"})
      end
    end

    test "us not_found" do
      use_cassette "conditions/us_not_found" do
        assert {:error, @not_found} = Conditions.get({:us, "CA", "USDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "us_zip" do
      use_cassette "conditions/us_zip" do
        assert {:ok, %Conditions{}} = Conditions.get({:us_zip, 60290})
      end
    end

    test "us_zip not_found" do
      use_cassette "conditions/us_zip_not_found" do
        assert {:error, @not_found} = Conditions.get({:us_zip, -1})
      end
    end

    test "international" do
      use_cassette "conditions/international" do
        assert {:ok, %Conditions{}} = Conditions.get({:international, "Australia", "Sydney"})
      end
    end

    test "international not_found" do
      use_cassette "conditions/international_not_found" do
        assert {:error, @not_found} = Conditions.get({:international, "Australia", "AUDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "geo" do
      use_cassette "conditions/geo" do
        assert {:ok, %Conditions{}} = Conditions.get({:geo, 37.8, -122.4})
      end
    end

    test "geo not_found" do
      use_cassette "conditions/geo_not_found" do
        assert {:error, @not_found} = Conditions.get({:geo, 2500.0, -5000.0})
      end
    end

    test "airport" do
      use_cassette "conditions/airport" do
        assert {:ok, %Conditions{}} = Conditions.get({:airport, "KJFK"})
      end
    end

    test "airport not_found" do
      use_cassette "conditions/airport_not_found" do
        assert {:error, @not_found} = Conditions.get({:airport, "AIRUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "pws" do
      use_cassette "conditions/pws" do
        assert {:ok, %Conditions{}} = Conditions.get({:pws, "KCASANFR70"})
      end
    end

    test "pws not_found" do
      use_cassette "conditions/pws_not_found" do
        assert {:error, @station_offline} = Conditions.get({:pws, "NOT_A_PWS_ID"})
      end
    end

    test "auto_ip" do
      use_cassette "conditions/auto_ip" do
        assert {:ok, %Conditions{}} = Conditions.get({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "conditions/auto_ip_custom" do
        assert {:ok, %Conditions{}} = Conditions.get({:auto_ip, {185, 1, 74, 1}})
      end
    end

    test "auto_ip with 'wrong' ip address tuple" do
      assert_raise ArgumentError, fn ->
        Conditions.get({:auto_ip, {"185", "1", "74", "1"}})
      end
    end

    test "auto_ip ArgumentError when no 4 element tuple is given" do
      assert_raise ArgumentError, fn ->
        Conditions.get({:auto_ip, "185.1.74.1"})
      end
    end

    test "ArgumentError" do
      assert_raise ArgumentError, fn ->
        Conditions.get(:not_an_argument)
      end
    end
  end
end
