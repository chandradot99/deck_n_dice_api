defmodule DeckNDice.Repo.Migrations.CreateGameTimeControlSettings do
  use Ecto.Migration

  def change do
    create table(:game_time_control_settings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :enable_total_game_timer, :boolean, default: false
      add :enable_per_player_timer, :boolean, default: false
      add :enable_per_move_timer, :boolean, default: false
      add :total_game_time_seconds, :string
      add :per_player_time_seconds, :string
      add :per_move_time_seconds, :string
      add :game_id, references(:games, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:game_time_control_settings, [:game_id])
  end
end
