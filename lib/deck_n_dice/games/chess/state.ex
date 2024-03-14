defmodule DeckNDice.Games.Chess.State do
  @moduledoc """
  This will store the chess state of a game.
  """

  use Agent, restart: :temporary

  @doc """
  Starts a new state.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets game state
  """
  def get(pid) do
    Agent.get(pid, & &1)
  end

  @doc """
  Updates the game state
  """
  def update(pid, state) do
    Agent.update(pid, fn _ -> state end)
  end
end
