defmodule PolishValidatorsIbanTest do
  use ExUnit.Case
  doctest PolishValidators

  test "valid iban with PL prefix" do
    assert PolishValidators.Iban.validate("PL61109010140000071219812874") == { :ok, "Valid" }
  end

  test "valid iban without PL prefix" do
    assert PolishValidators.Iban.validate("61109010140000071219812874") == { :ok, "Valid" }
  end

  test "iban with invalid checksum" do
    assert PolishValidators.Iban.validate("PL61109010140000071219812871") == { :error, "Wrong checksum" }
  end

  test "iban with wrong length" do
    assert PolishValidators.Iban.validate("PL611090101400000712198128") == { :error, "Invalid length" }
  end
end

