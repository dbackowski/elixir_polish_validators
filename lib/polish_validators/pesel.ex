defmodule PolishValidators.Pesel do
  import Enum, only: [zip: 1, reduce: 3]
  import List, only: [last: 1]
  import PolishValidators.Common

  @weights [1, 3, 7, 9, 1, 3, 7, 9, 1, 3]
  
  @moduledoc """
  Provides function validate/1 to check Pesel number.
  """

  @doc """
  Validate Pesel number.

  ## Examples

      iex> PolishValidators.Pesel.validate("44051401359")
      { :ok, "Valid" }

      iex> PolishValidators.Pesel.validate("44051401354")
      { :error, "Wrong checksum" }

      iex> PolishValidators.Pesel.validate("44051401")
      { :error, "Invalid length" }
  
  """
  def validate(pesel) when is_binary(pesel) do
    pesel_length = validate_length(pesel, 11)
    
    case pesel_length do
      { :ok, pesel } ->
        pesel_integers_list = to_integers_list(pesel)
        [pesel_integers_list, @weights]
          |> zip
          |> calculate_checksum
          |> validate_checksum(last(pesel_integers_list))
      _ -> pesel_length
    end
  end

  def validate(_) do
    throw "Pesel must be a string."
  end

  defp calculate_checksum(pesel) do
    (10 - (reduce(pesel, 0, &reduce_checksum/2) |> rem(10)))
      |> rem(10)
  end

  defp reduce_checksum(pesel, acc) do
    acc + elem(pesel, 0) * elem(pesel, 1)
  end
end