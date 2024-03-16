defmodule DeckNDiceWeb.GameJSON do
  alias DeckNDice.Games.Game
  alias DeckNDice.Users.User

  @doc """
  Renders a single account.
  """
  def show(%{game: game}) do
    %{data: game_data(game)}
  end

  def show_game_player(%User{} = game_player) do
    %{
      id: game_player.id,
      name: game_player.full_name,
      email: game_player.email
    }
  end

  def render_game_players(%Ecto.Association.NotLoaded{}), do: []

  def render_game_players(players) do
    Enum.map(players, fn player -> show_game_player(player) end)
  end

  defp game_data(%Game{} = game) do
    %{
      id: game.id,
      status: game.status,
      type: game.type,
      created_by: game.created_by,
      started_at: game.started_at,
      finished_at: game.finished_at,
      game_data: game.game_data,
      players: render_game_players(game.game_players)
    }
  end
end
