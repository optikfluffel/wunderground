# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :wunderground, api_key: System.get_env("WUNDERGROUND_API_KEY")

if Mix.env == :test do
  config :exvcr, [
    filter_sensitive_data: [
      [pattern: "(?<=http:\/\/api\\.wunderground\\.com\/api\/)(\\w+)(?=\/.+)", placeholder: "<<wunderground_api_key>>"]
    ],
    filter_url_params: true,
    response_headers_blacklist: ["Set-Cookie"]
  ]
end
