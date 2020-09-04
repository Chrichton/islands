defmodule CoordinateTest do
  @moduledoc false

  use ExUnit.Case, async: true
  alias IslandsEngine.Coordinate

  setup do
    {:ok, [i: 99, c: Coordinate.new(2, 5)]}
  end

  test "can create a new coordinate", cx do
    assert cx.c == {:ok, %IslandsEngine.Coordinate{col: 5, row: 2}}
  end

  test "invalid upper bound column" do
    assert Coordinate.new(5, 11) == {:error, :invalid_coordinate}
  end

  test "invalid lower bound column" do
    assert Coordinate.new(5, 0) == {:error, :invalid_coordinate}
  end

  test "invalid upper bound row" do
    assert Coordinate.new(11, 2) == {:error, :invalid_coordinate}
  end

  test "invalid lower bound row" do
    assert Coordinate.new(0, 2) == {:error, :invalid_coordinate}
  end

  test "validates coordinate" do
    assert Coordinate.new(5, 2) == {:ok, %IslandsEngine.Coordinate{row: 5, col: 2}}
  end

  # How to test this?
  # test "create manually without col" do
  #   assert_raise ArgumentError, "Must supply row and col", fn -> Coordinate{row: 5}
  # end

  # test "create manually without row" do
  #   assert_raise ArgumentError, "Must supply row and col", fn -> Coordinate{col: 5}
  # end

  # test "create manually without row and col" do
  #   assert_raise ArgumentError, "Must supply row and col", fn -> Coordinate{}
  # end


end
