defmodule DeckNDiceWeb.GameJSON do
  alias DeckNDice.Games.Game
  alias DeckNDice.Games.GamePlayer

  @doc """
  Renders a single account.
  """
  def show(%{game: game}) do
    %{data: game_data(game)}
  end

  def show_game_player(%GamePlayer{} = game_player) do
    %{
      id: game_player.player_id,
      identifier: game_player.player_identifier,
      name: game_player.player.full_name,
      email: game_player.player.email,
      gender: game_player.player.gender,
      username: game_player.player.account.username
    }
  end

  def render_game_players(%Ecto.Association.NotLoaded{}), do: []

  def render_game_players(players) do
    Enum.map(players, fn player -> show_game_player(player) end)
  end

  def render_game_time_control_settings(%Ecto.Association.NotLoaded{}), do: %{}

  def render_game_time_control_settings(time_setting) do
    %{
      enable_total_game_timer: time_setting.enable_total_game_timer,
      enable_per_player_timer: time_setting.enable_per_player_timer,
      enable_per_move_timer: time_setting.enable_per_move_timer,
      total_game_time_seconds: time_setting.total_game_time_seconds,
      per_player_time_seconds: time_setting.per_player_time_seconds,
      per_move_time_seconds: time_setting.per_move_time_seconds
    }
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
      players: render_game_players(game.game_players),
      time_control_setting: render_game_time_control_settings(game.game_time_control_setting)
    }
  end
end
