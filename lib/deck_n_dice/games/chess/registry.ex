defmodule DeckNDice.Games.Chess.Registry do
  @moduledoc """
  Registry for mapping chess game process to and indentifier.
  This contains Client API's and Server Callbacks
  """

  use GenServer
  alias DeckNDice.Games.Chess.State, as: ChessState

  ## Client API

  @doc """
  Starts the Chess registry
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Adds new game state process to registry
  """
  def create(pid, name) do
    GenServer.call(pid, {:create, name})
  end

  @doc """
  Returns the state pid for `name` stored in registry.
  """
  def get(pid, name) do
    GenServer.call(pid, {:get, name})
  end

  ## Server Callbacks

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}

    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:get, name}, _from, {names, _} = state) do
    {:reply, Map.fetch(names, name), state}
  end

  @impl true
  def handle_call({:create, name}, _from, {names, refs} = state) do
    if Map.has_key?(names, name) do
      {:reply, {:error, "Process already registered with this name in Chess Registry"}, state}
    else
      {:ok, pid} = DynamicSupervisor.start_child(Chess.GameSupervisor, ChessState)
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)

      {:reply, {:ok, "Process registered with name #{name} in the Chess Registry"}, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected error in ChessRegistry: #{inspect(msg)}")
    {:noreply, state}
  end
end
