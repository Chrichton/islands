ExUnit.start()

defmodule GameTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias IslandsEngine.Game

  test "overlay error" do
    {:ok, game} = Game.start_link("Dino")
    :ok = Game.add_player(game, "Pebbles")
    :ok = Game.position_island(game, :player1, :atoll, 1, 1)
    {:error, :overlapping_island} = Game.position_island(game, :player1, :dot, 1, 1)
  end
end
