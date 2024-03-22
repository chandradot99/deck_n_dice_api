defmodule DeckNDice.Repo.Migrations.CreateGameResults do
  use Ecto.Migration

  def change do
    create table(:game_results, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :winner_type, :string
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id), null: false
      add :winner_player_id, references(:game_players, on_delete: :nothing, type: :binary_id)
      add :winner_team_id, references(:game_teams, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:game_results, [:winner_player_id])
    create index(:game_results, [:winner_team_id])
  end
end
