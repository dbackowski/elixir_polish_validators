defmodule PolishValidatorsRegonTest do
  use ExUnit.Case
  doctest PolishValidators

  test "valid regon (9 digits)" do
    assert PolishValidators.Regon.validate("517001918") == { :ok, "Valid" }
  end

  test "valid regon (14 digits)" do
    assert PolishValidators.Regon.validate("87515234723651") == { :ok, "Valid" }
  end

  test "regon (9 digits) with invalid checksum" do
    assert PolishValidators.Regon.validate("517001912") == { :error, "Wrong checksum" }
  end

  test "regon (14 digits) with invalid checksum" do
    assert PolishValidators.Regon.validate("87515234723652") == { :error, "Wrong checksum" }
  end

  test "regon with wrong length" do
    assert PolishValidators.Regon.validate("51700191") == { :error, "Invalid length" }
  end
end

