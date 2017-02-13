defmodule DeliveryTest do
  use ExUnit.Case
  doctest Delivery

  test "the truth" do
    assert 1 + 1 == 2
  end
  test "load files" do
       [first | _] = Delivery.PostalCode.DataParser.parse_data
    assert elem(first, 0) == "00601"
  end
end
