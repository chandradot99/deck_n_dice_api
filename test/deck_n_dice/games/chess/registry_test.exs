defmodule DeckNDice.Games.Chess.RegistryTest do
  use ExUnit.Case, async: true
  alias DeckNDice.Games.Chess.Registry, as: ChessRegistry
  alias DeckNDice.Games.Chess.State, as: ChessState

  setup do
    registry = start_supervised!(ChessRegistry)
    %{registry: registry}
  end

  test "spawns new chess games processes", %{registry: registry} do
    assert ChessRegistry.get(registry, "game1") == :error

    ChessRegistry.create(registry, "game1")
    assert {:ok, pid} = ChessRegistry.get(registry, "game1")

    ChessState.update(pid, %{current_turn: "white"})
    assert ChessState.get(pid) == %{current_turn: "white"}
  end

  test "removes bucket on crash", %{registry: registry} do
    ChessRegistry.create(registry, "game1")
    {:ok, pid} = ChessRegistry.get(registry, "game1")

    # Stops the process with non-normal reason
    Agent.stop(pid, :shutdown)
    assert ChessRegistry.get(registry, "game1") == :error
  end
end
