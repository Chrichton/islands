ExUnit.start()

defmodule BoardTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias IslandsEngine.{Coordinate, Island, Board}

  test "creates an empty map" do
    assert %{} = Board.new()
  end

  test "true if all_islands_positioned?" do
    b = Board.new()

    b =
      Enum.reduce(Island.types(), b, fn x, b ->
        Map.put_new(b, x, true)
      end)

    assert Board.all_islands_positioned?(b)
  end

  test "false if not all_islands_positioned?" do
    b = Board.new()

    b = Map.put_new(b, :square, true)

    refute Board.all_islands_positioned?(b)
  end

  test "position same islands overlap" do
    board = Board.new()
    {:ok, coordinate} = Coordinate.new(1, 1)
    {:ok, island} = Island.new(:atoll, coordinate)

    board1 = Board.position_island(board, :atoll, island)
    board2 = Board.position_island(board1, :atoll, island)

    assert board1 = board2
  end

  test "position different islands overlap" do
    board = Board.new()
    {:ok, coordinate} = Coordinate.new(1, 1)
    {:ok, island1} = Island.new(:atoll, coordinate)
    {:ok, island2} = Island.new(:dot, coordinate)

    board1 = Board.position_island(board, :atoll, island1) #Heiko island should have property: type (:atoll)
    result = Board.position_island(board1, :dot, island2)

    assert {:error, :overlapping_island} = result
  end
end
