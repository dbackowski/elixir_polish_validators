defmodule PolishValidators.Pesel do
  import String, only: [split: 3]
  import Enum, only: [zip: 1, reduce: 3, map: 2]
  
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
  #def validate(pesel) do#when is_binary(pesel) do
  def validate(pesel) do
    pesel_length = validate_length(pesel)
    
    case pesel_length do
      { :ok, pesel } ->
        pesel_integers_list = to_integers_list(pesel)
        [pesel_integers_list, @weights]
          |> zip
          |> calculate_checksum
          |> validate_checksum(pesel_integers_list)
      _ -> pesel_length
    end
  end

  defp to_integers_list(pesel) do
    to_string(pesel) 
      |> split("", trim: true)
      |> map(&(String.to_integer(&1)))
  end

  defp validate_length(pesel) do
    case String.length(pesel) do
      11 -> { :ok, pesel }
      _ -> { :error, "Invalid length" }
    end
  end

  defp calculate_checksum(pesel) do
    reduce(pesel, 0, &reduce_checksum/2)
  end

  defp reduce_checksum(pesel, acc) do
    acc + elem(pesel, 0) * elem(pesel, 1)
  end

  defp validate_checksum(checksum, pesel_integers_list) do
    if (10 - (rem(checksum, 10))) |> rem(10) == List.last(pesel_integers_list) do
      { :ok, "Valid" }
    else
      { :error, "Wrong checksum" }
    end
  end

  #def validate(pesel) do
  #  throw "Pesel must be a string."
  #end
end