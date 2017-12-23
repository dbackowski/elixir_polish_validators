defmodule PolishValidatorsNipTest do
  use ExUnit.Case
  doctest PolishValidators

  test "valid pesel" do
    assert PolishValidators.Nip.validate("44051401359") == { :ok, "Valid" }
  end
  
  test "pesel with invalid checksum" do
    assert PolishValidators.Nip.validate("44051401354") == { :error, "Wrong checksum" }
  end

  test "pesel with wrong length" do
    assert PolishValidators.Nip.validate("2") == { :error, "Invalid length" }
  end
end
