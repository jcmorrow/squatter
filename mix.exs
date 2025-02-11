defmodule Squatter.Mixfile do
  use Mix.Project

  def project do
    [app: :squatter,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: [main_module: Squatter],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
      {:floki, "~> 0.10.1"},
      {:httpotion, "~> 3.0.0"},
      {:mock, "~> 0.1.1", only: :test},
      {:timex, "~> 3.0"},
    ]
  end
end
