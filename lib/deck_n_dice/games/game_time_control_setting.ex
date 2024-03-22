defmodule DeckNDice.Games.GameTimeControlSetting do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_time_control_settings" do
    field :enable_total_game_timer, :boolean, default: false
    field :enable_per_player_timer, :boolean, default: false
    field :enable_per_move_timer, :boolean, default: false
    field :total_game_time_seconds, :string
    field :per_player_time_seconds, :string
    field :per_move_time_seconds, :string
    belongs_to :game, DeckNDice.Games.Game

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_time_control_settings, attrs) do
    game_time_control_settings
    |> cast(attrs, [
      :enable_total_game_timer,
      :enable_per_player_timer,
      :enable_per_move_timer,
      :total_game_time_seconds,
      :per_player_time_seconds,
      :per_move_time_seconds
    ])
  end
end
