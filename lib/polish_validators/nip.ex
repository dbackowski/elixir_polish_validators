defmodule PolishValidators.Nip do
  import String, only: [split: 3, to_integer: 1, length: 1]
  import Enum, only: [zip: 1, reduce: 3, map: 2]
  import List, only: [last: 1]
  import Kernel, except: [length: 1]

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

  def validate(nip) do
    nip_length = validate_length(nip)
    
    case nip_length do
      { :ok, nip } ->
        nip_integers_list = to_integers_list(nip)
        [nip_integers_list, @weights]
          |> zip
          |> calculate_checksum
          |> validate_checksum(nip_integers_list)
      _ -> nip_length
    end
  end

  defp validate_length(nip) do
    case length(nip) do
      10 -> { :ok, nip }
      _ -> { :error, "Invalid length" }
    end
  end

  defp to_integers_list(nip) do
    to_string(nip) 
      |> split("", trim: true)
      |> map(&(to_integer(&1)))
  end

  defp calculate_checksum(nip) do
    reduce(nip, 0, &reduce_checksum/2)
  end

  defp reduce_checksum(nip, acc) do
    acc + elem(nip, 0) * elem(nip, 1)
  end

  defp validate_checksum(checksum, nip_integers_list) do
    if rem(checksum, 11) == last(nip_integers_list) do
      { :ok, "Valid" }
    else
      { :error, "Wrong checksum" }
    end
  end
end