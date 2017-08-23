defmodule Wunderground.Mixfile do
  use Mix.Project

  def project do
    [
      app: :wunderground,
      version: "0.0.2",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test,

        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        flags: [:error_handling, :race_conditions, :underspecs]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:exvcr, "~> 0.8", only: [:test], runtime: false},
      {:excoveralls, "~> 0.7", only: [:test], runtime: false},
      {:inch_ex, "~> 0.5", only: [:docs], runtime: false}
    ]
  end

  defp description do
    "⚠️ WORK IN PROGRESS: A basic wrapper for the Weather Underground API."
  end

  defp package do
    [
      name: "wunderground",
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["optikfluffel"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => "https://github.com/optikfluffel/wunderground"}
     ]
  end
end
