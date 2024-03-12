defmodule DeckNDice.Games.Chess.StateTest do
  use ExUnit.Case, async: true
  alias DeckNDice.Games.Chess.State, as: ChessState

  setup do
    {:ok, pid} = ChessState.start_link([])
    %{pid: pid}
  end

  test "stores values by key", %{pid: pid} do
    assert ChessState.get(pid, "current_turn") == nil

    ChessState.update(pid, "current_turn", "white")
    assert ChessState.get(pid, "current_turn") == "white"
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(ChessState, []).restart == :temporary
  end
end
