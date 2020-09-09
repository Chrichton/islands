#---
# Excerpted from "Functional Web Development with Elixir, OTP, and Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/lhelph for more book information.
#---

#Heiko: I don't like, that the names of state aren't defined. You have to know them.
#       No intellisense possible. It crashes at run-time. That's normal Elixir

defmodule IslandsEngine.Rules do
  @moduledoc false

  #Heiko: because a struct is a KeyValueMap, the key for player1 is :player1
  defstruct state: :initialized,
            player1: :islands_not_set,
            player2: :islands_not_set

  alias __MODULE__

  def new(), do: %Rules{}

  # Heiko: shouldn't check be called next next_rules?
  def check(%Rules{state: :initialized} = rules, :add_player), do:
    {:ok, %Rules{rules | state: :players_set}}  # Heiko: returns the old rules with state set to :players_set

  def check(%Rules{state: :players_set} = rules, {:position_islands, player}) do
    case Map.fetch!(rules, player) do
      :islands_set -> :error
      :islands_not_set -> {:ok, rules}
    end
  end

  def check(%Rules{state: :players_set} = rules, {:set_islands, player}) do
    rules = Map.put(rules, player, :islands_set)
    case both_players_islands_set?(rules) do
      true  -> {:ok, %Rules{rules | state: :player1_turn}}
      false -> {:ok, rules}
    end
  end

  def check(%Rules{state: :player1_turn} = rules, {:guess_coordinate, :player1}), do:
    {:ok, %Rules{rules | state: :player2_turn}}

  def check(%Rules{state: :player1_turn} = rules, {:win_check, win_or_not}) do
    case win_or_not do
      :no_win -> {:ok, rules}
      :win -> {:ok, %Rules{rules | state: :game_over}}
    end
  end

  def check(%Rules{state: :player2_turn} = rules, {:guess_coordinate, :player2}), do:
    {:ok, %Rules{rules | state: :player1_turn}}

  def check(%Rules{state: :player2_turn} = rules, {:win_check, win_or_not}) do
    case win_or_not do
      :no_win -> {:ok, rules}
      :win -> {:ok, %Rules{rules | state: :game_over}}
    end
  end

  def check(_state, _action), do: :error

  defp both_players_islands_set?(rules), do:
    rules.player1 == :islands_set && rules.player2 == :islands_set
end
