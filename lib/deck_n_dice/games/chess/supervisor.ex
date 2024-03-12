defmodule DeckNDice.Games.Chess.Supervisor do
  use Supervisor
  alias DeckNDice.Games.Chess.Registry, as: ChessRegistry

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {DynamicSupervisor, name: Chess.GameSupervisor, strategy: :one_for_one},
      {ChessRegistry, name: ChessRegistry}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
