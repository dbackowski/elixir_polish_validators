defmodule PolishValidators.Common do
  import String, only: [split: 3, length: 1, to_integer: 1]
  import Enum, only: [map: 2]
  import Kernel, except: [length: 1]

  #@moduledoc """
  #Provides common functions to polish validators.
  #"""

  @moduledoc false

  @doc """
  Validate length of passed string.

  ## Examples

      iex> PolishValidators.Common.validate_length("1234", 4)
      { :ok, "1234" }

      iex> PolishValidators.Common.validate_length("1234", [2, 4])
      { :ok, "1234" }

      iex> PolishValidators.Common.validate_length("1234", 5)
      { :error, "Invalid length" }

  """
  def validate_length(string, valid_length) do
    valid_length = cond do
      is_number(valid_length) -> [valid_length]
      is_list(valid_length) -> valid_length
    end

    cond do
      length(string) in valid_length -> { :ok, string }
      true -> { :error, "Invalid length" }
    end
  end

  @doc """
  Validate passed checksum with control digit.

  ## Examples

      iex> PolishValidators.Common.validate_checksum(2, 2)
      { :ok, "Valid" }

      iex> PolishValidators.Common.validate_checksum(2, 1)
      { :error, "Wrong checksum" }

  """
  def validate_checksum(checksum, control_digit) do
    if (checksum == control_digit) do
      { :ok, "Valid" }
    else
      { :error, "Wrong checksum" }
    end
  end

  @doc """
  Convert string to list of integers.

  ## Examples

      iex> PolishValidators.Common.to_integers_list("123")
      [1, 2, 3]

  """
  def to_integers_list(number) do
    to_string(number) 
      |> split("", trim: true)
      |> map(&(to_integer(&1)))
  end
end