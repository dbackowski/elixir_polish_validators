defmodule PolishValidatorsNipTest do
  use ExUnit.Case
  doctest PolishValidators

  test "valid nip" do
    assert PolishValidators.Nip.validate("6597068174") == { :ok, "Valid" }
  end
  
  test "nip with invalid checksum" do
    assert PolishValidators.Nip.validate("6597068172") == { :error, "Wrong checksum" }
  end

  test "nip with wrong length" do
    assert PolishValidators.Nip.validate("2") == { :error, "Invalid length" }
  end
end
