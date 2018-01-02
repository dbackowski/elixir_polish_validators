defmodule PolishValidators.Regon do
  import String, only: [split: 3, to_integer: 1, length: 1]
  import Enum, only: [zip: 1, reduce: 3, map: 2]
  import List, only: [last: 1]
  import Kernel, except: [length: 1]

  @weights9 [8, 9, 2, 3, 4, 5, 6, 7]
  @weights14 [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8]

  @moduledoc """
  Provides function validate/1 to check Regon number.
  """

  @doc """
  Validate regon number.

  ## Examples

      iex> PolishValidators.Regon.validate("517001918")
      { :ok, "Valid" }

      iex> PolishValidators.Regon.validate("87515234723651")
      { :ok, "Valid" }

      iex> PolishValidators.Regon.validate("517001912")
      { :error, "Wrong checksum" }

      iex> PolishValidators.Regon.validate("87515234723652")
      { :error, "Wrong checksum" }

      iex> PolishValidators.Regon.validate("51700191")
      { :error, "Invalid length" }
  
  """

  def validate(regon) do
    regon_length = validate_length(regon)
    
    case regon_length do
      { :ok, regon } ->
        regon_integers_list = to_integers_list(regon)
        [regon_integers_list, weights(regon)]
          |> zip
          |> calculate_checksum
          |> validate_checksum(regon_integers_list)
      _ -> regon_length
    end
  end

  defp weights(regon) do
    case length(regon) do
      9 -> @weights9
      14 -> @weights14
    end
  end

  defp validate_length(regon) do
    case length(regon) do
      n when n in [9, 14] -> { :ok, regon }
      _ -> { :error, "Invalid length" }
    end
  end

  defp to_integers_list(regon) do
    to_string(regon) 
      |> split("", trim: true)
      |> map(&(to_integer(&1)))
  end

  defp calculate_checksum(regon) do
    reduce(regon, 0, &reduce_checksum/2)
  end

  defp reduce_checksum(regon, acc) do
    acc + elem(regon, 0) * elem(regon, 1)
  end

  defp validate_checksum(checksum, regon_integers_list) do
    if rem(checksum, 11) == last(regon_integers_list) do
      { :ok, "Valid" }
    else
      { :error, "Wrong checksum" }
    end
  end
end
