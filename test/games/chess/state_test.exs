defmodule Games.Chess.StateTest do
  use ExUnit.Case, async: true
  alias Games.Chess.State, as: ChessState

  setup do
    {:ok, pid} = ChessState.init([])
    %{pid: pid}
  end

  test "stores values by key", %{pid: pid} do
    assert ChessState.get(pid, "current_turn") == nil

    ChessState.update(pid, "current_turn", "white")
    assert ChessState.get(pid, "current_turn") == "white"
  end
end
