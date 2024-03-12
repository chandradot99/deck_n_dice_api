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
  Gets a value from the state by `key`
  """
  def get(pid, key) do
    Agent.get(pid, fn state -> Map.get(state, key) end)
  end

  @doc """
  Puts the `value` for the given `key` in the state.
  """
  def update(pid, key, value) do
    Agent.update(pid, fn state -> Map.put(state, key, value) end)
  end
end
