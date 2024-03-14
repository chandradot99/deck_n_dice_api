defmodule DeckNDice.Games.Chess do
  @moduledoc """
  Chess Context API's
  """

  alias DeckNDice.Games.Chess.Registry, as: ChessRegistry
  alias DeckNDice.Games.Chess.State, as: ChessState

  @doc """
  This will start a new chess game
  """
  def start_new_game(name) do
    ChessRegistry.create(ChessRegistry, name)
  end

  @doc """
  Get the chess game current state
  """
  def get_game_state(name) do
    {:ok, pid} = ChessRegistry.get(ChessRegistry, name)
    ChessState.get(pid)
  end

  @doc """
  Update the chess game current state
  """
  def update_game_state(name, state) do
    {:ok, pid} = ChessRegistry.get(ChessRegistry, name)
    ChessState.update(pid, state)
  end

  def end_game() do
  end
end
