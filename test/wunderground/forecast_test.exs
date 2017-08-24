defmodule Wunderground.ForecastTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Wunderground.Forecast
  alias Wunderground.Forecast.Result

  @not_found {:not_found, "No cities match your search query"}
  @station_offline {:station_offline, "The station you're looking for either doesn't exist or is simply offline right now."}
  @invalid_ip {:invalid_ip, "einval"}

  setup_all do
    HTTPoison.start()
    ExVCR.Config.filter_url_params(true)

    :ok
  end

  describe "get/1" do
    test "us" do
      use_cassette "forecast/us" do
        assert {:ok, %Result{}} = Forecast.get({:us, "CA", "San_Francisco"})
      end
    end

    test "us not_found" do
      use_cassette "forecast/us_not_found" do
        assert {:error, @not_found} = Forecast.get({:us, "CA", "USDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "us_zip" do
      use_cassette "forecast/us_zip" do
        assert {:ok, %Result{}} = Forecast.get({:us_zip, 60290})
      end
    end

    test "us_zip not_found" do
      use_cassette "forecast/us_zip_not_found" do
        assert {:error, @not_found} = Forecast.get({:us_zip, -1})
      end
    end

    test "international" do
      use_cassette "forecast/international" do
        assert {:ok, %Result{}} = Forecast.get({:international, "Australia", "Sydney"})
      end
    end

    test "international not_found" do
      use_cassette "forecast/international_not_found" do
        assert {:error, @not_found} = Forecast.get({:international, "Australia", "AUDUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "geo" do
      use_cassette "forecast/geo" do
        assert {:ok, %Result{}} = Forecast.get({:geo, 37.8, -122.4})
      end
    end

    test "geo not_found" do
      use_cassette "forecast/geo_not_found" do
        assert {:error, @not_found} = Forecast.get({:geo, 2500.0, -5000.0})
      end
    end

    test "airport" do
      use_cassette "forecast/airport" do
        assert {:ok, %Result{}} = Forecast.get({:airport, "KJFK"})
      end
    end

    test "airport not_found" do
      use_cassette "forecast/airport_not_found" do
        assert {:error, @not_found} = Forecast.get({:airport, "AIRUBFOURZEGBNUIZDSNGIUZFV"})
      end
    end

    test "pws" do
      use_cassette "forecast/pws" do
        assert {:ok, %Result{}} = Forecast.get({:pws, "KCASANFR70"})
      end
    end

    test "pws not_found" do
      use_cassette "forecast/pws_not_found" do
        assert {:error, @station_offline} = Forecast.get({:pws, "NOT_A_PWS_ID"})
      end
    end

    test "auto_ip" do
      use_cassette "forecast/auto_ip" do
        assert {:ok, %Result{}} = Forecast.get({:auto_ip})
      end
    end

    test "auto_ip with given ip address" do
      use_cassette "forecast/auto_ip_custom" do
        assert {:ok, %Result{}} = Forecast.get({:auto_ip, {185, 1, 74, 1}})
      end
    end

    test "auto_ip with 'wrong' ip address" do
      use_cassette "forecast/auto_ip_custom" do
        assert {:error, @invalid_ip} = Forecast.get({:auto_ip, {"185", "1", "74", "1"}})
      end
    end

    test "auto_ip ArgumentError when no 4 element tuple is given" do
      assert_raise ArgumentError, fn ->
        Forecast.get({:auto_ip, "185.1.74.1"})
      end
    end

    test "ArgumentError" do
      assert_raise ArgumentError, fn ->
        Forecast.get(:not_an_argument)
      end
    end
  end
end
