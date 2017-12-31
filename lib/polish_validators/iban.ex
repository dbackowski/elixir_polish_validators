defmodule PolishValidators.Iban do
  import String, only: [replace_prefix: 3, slice: 2, to_integer: 1, length: 1]
  import Kernel, except: [length: 1]

  @moduledoc """
  Provides function validate/1 to check IBAN (PL) number.
  """

  @doc """
  Validate IBAN number.

  ## Examples

      iex> PolishValidators.Iban.validate("PL61109010140000071219812874")
      { :ok, "Valid" }

      iex> PolishValidators.Iban.validate("PL61109010140000071219812871")
      { :error, "Wrong checksum" }

      iex> PolishValidators.Iban.validate("PL611090101400000712198128")
      { :error, "Invalid length" }
  
  """

  def validate(iban) do
    iban_length = replace_prefix(iban, "PL", "")
                    |> validate_length
    
    case iban_length do
      { :ok, iban } ->
        validate_checksum(iban)
      _ -> iban_length
    end
  end

  defp validate_length(iban) do
    case length(iban) do
      26 -> { :ok, iban }
      _ -> { :error, "Invalid length" }
    end
  end

  defp validate_checksum(iban) do
    checksum = "#{slice(iban, 2..-1)}2521#{slice(iban, 0..1)}"
                 |> to_integer
                 |> rem(97)
    
    if (checksum == 1) do
      { :ok, "Valid" }
    else
      { :error, "Wrong checksum" }
    end
  end
end