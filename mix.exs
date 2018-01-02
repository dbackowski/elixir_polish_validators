defmodule PolishValidators.Mixfile do
  use Mix.Project

  def project do
    [
      app: :polish_validators,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Library for validate polish numbers: PESEL, NIP, REGON, IBAN (PL)
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README.md"],
     maintainers: ["Damian Baćkowski"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/dbackowski/elixir_polish_validators",
              "Docs" => "https://hexdocs.pm/polish_validators/"}
     ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.11", only: :dev},
      {:earmark, "~> 0.1", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
