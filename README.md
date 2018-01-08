# PolishValidators [![Build Status](https://travis-ci.org/dbackowski/elixir_polish_validators.svg?branch=master)](https://travis-ci.org/dbackowski/elixir_polish_validators)

Library for validate polish numbers: PESEL, NIP, REGON, IBAN (PL)

## Usage

```elixir
iex> PolishValidators.Pesel.validate("44051401359")
{ :ok, "Valid" }

iex> PolishValidators.Nip.validate("6597068174")
{ :ok, "Valid" }

iex> PolishValidators.Iban.validate("PL61109010140000071219812874")
{ :ok, "Valid" }

iex> PolishValidators.Regon.validate("517001918")
{ :ok, "Valid" }
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `polish_validators` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:polish_validators, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/polish_validators](https://hexdocs.pm/polish_validators).

