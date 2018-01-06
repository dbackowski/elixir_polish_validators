defmodule PolishValidators.Iban do
  import String, only: [replace_prefix: 3, slice: 2, to_integer: 1]
  import PolishValidators.Common

  @moduledoc """
  Provides function validate/1 to check IBAN (PL) number.
  """

  @doc """
  Validate IBAN number.

  ## Examples

      iex> PolishValidators.Iban.validate("PL61109010140000071219812874")
      { :ok, "Valid" }

      iex> PolishValidators.Iban.validate("61109010140000071219812874")
      { :ok, "Valid" }

      iex> PolishValidators.Iban.validate("PL61109010140000071219812871")
      { :error, "Wrong checksum" }

      iex> PolishValidators.Iban.validate("PL611090101400000712198128")
      { :error, "Invalid length" }
  
  """
  def validate(iban) when is_binary(iban) do
    iban_length = replace_prefix(iban, "PL", "")
                    |> validate_length(26)
    
    case iban_length do
      { :ok, iban } ->
        calculate_checksum(iban)
          |> validate_checksum(1)
      _ -> iban_length
    end
  end

  def validate(_) do
    throw "IBAN must be a string."
  end

  defp calculate_checksum(iban) do
    "#{slice(iban, 2..-1)}2521#{slice(iban, 0..1)}"
      |> to_integer
      |> rem(97)
  end
end
