defmodule PolishValidators.Nip do
  import Enum, only: [zip: 1, reduce: 3]
  import List, only: [last: 1]
  import PolishValidators.Common

  @weights [6, 5, 7, 2, 3, 4, 5, 6, 7]

  @moduledoc """
  Provides function validate/1 to check NIP number.
  """

  @doc """
  Validate NIP number.

  ## Examples

      iex> PolishValidators.Nip.validate("6597068174")
      { :ok, "Valid" }

      iex> PolishValidators.Nip.validate("6597068172")
      { :error, "Wrong checksum" }

      iex> PolishValidators.Nip.validate("65970681")
      { :error, "Invalid length" }
  
  """
  @spec validate(String.t) :: {atom, String.t}
  def validate(nip) when is_binary(nip) do
    nip_length = validate_length(nip, 10)
    
    case nip_length do
      { :ok, nip } ->
        nip_integers_list = to_integers_list(nip)
        [nip_integers_list, @weights]
          |> zip
          |> calculate_checksum
          |> validate_checksum(last(nip_integers_list))
      _ -> nip_length
    end
  end

  def validate(_) do
    throw "NIP must be a string."
  end

  defp calculate_checksum(nip) do
    reduce(nip, 0, &reduce_checksum/2)
      |> rem(11)
  end

  defp reduce_checksum(nip, acc) do
    acc + elem(nip, 0) * elem(nip, 1)
  end
end