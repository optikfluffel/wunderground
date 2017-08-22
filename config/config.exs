# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :wunderground, api_key: System.get_env("WUNDERGROUND_API_KEY")
