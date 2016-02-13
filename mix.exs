defmodule Finicity.Mixfile do
  use Mix.Project

  def project do
    [app: :finicity,
     version: "0.0.4",
     description: "Client library for Finicity.",
     maintainers: ["Travis Jeffery"],
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpotion]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"},
      {:httpotion, "~> 2.1.0"},
      {:xml_builder, "~> 0.0.6"},
      {:floki, "~> 0.7"}
    ]
  end
end
