# Created by Heiko

ExUnit.start

defmodule RulesTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias IslandsEngine.Rules

  test "new" do
    rules = Rules.new()

    assert :initialized = rules.state
    assert :islands_not_set = rules.player1
    assert :islands_not_set = rules.player2
  end

  test "happy path" do
    rules = Rules.new()

    #:add_player
    {:ok, rules} = Rules.check(rules, :add_player)
    assert :players_set = rules.state
    assert :islands_not_set = rules.player1
    assert :islands_not_set = rules.player2

    #:position_islands
    {:ok, rules} = Rules.check(rules, {:position_islands, :player1})
    assert :players_set = rules.state
    assert :islands_not_set = rules.player1
    assert :islands_not_set = rules.player2

    {:ok, rules} = Rules.check(rules, {:position_islands, :player2})
    assert :players_set = rules.state
    assert :islands_not_set = rules.player1
    assert :islands_not_set = rules.player2

    #:set_islands
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})
    assert :players_set = rules.state
    assert :islands_not_set = rules.player1
    assert :islands_set = rules.player2

    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    assert :player1_turn = rules.state
    assert :islands_set = rules.player1
    assert :islands_set = rules.player2

    #:guess_coordinate
    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player1})
    assert :player2_turn = rules.state
    assert :islands_set = rules.player1
    assert :islands_set = rules.player2

    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player2})
    assert :player1_turn = rules.state
    assert :islands_set = rules.player1
    assert :islands_set = rules.player2

    #Heiko: :no_win or :win are returned from the Board.guess()-function to signal hit or not hit
    #:win_check
    {:ok, rules} = Rules.check(rules, {:win_check, :no_win})
    assert :player1_turn = rules.state
    assert :islands_set = rules.player1
    assert :islands_set = rules.player2

    {:ok, rules} = Rules.check(rules, {:win_check, :win})
    assert :game_over = rules.state
    assert :islands_set = rules.player1
    assert :islands_set = rules.player2
  end

  test "error paths" do
    rules = Rules.new()

    # Assert all states following :add_player are invalid
    assert :error = Rules.check(rules, {:position_islands, :player1})
    assert :error = Rules.check(rules, {:position_islands, :player2})

    assert :error = Rules.check(rules, {:set_islands, :player1})
    assert :error = Rules.check(rules, {:set_islands, :player2})

    assert :error = Rules.check(rules, {:guess_coordinate, :player1})
    assert :error = Rules.check(rules, {:guess_coordinate, :player2})


    # Set first state
    {:ok, rules} = Rules.check(rules, :add_player)

    assert :error = Rules.check(rules, :add_player)
    assert :error = Rules.check(rules, {:guess_coordinate, :player1})
    assert :error = Rules.check(rules, {:guess_coordinate, :player2})
  end

end
