defmodule DeckNDice.Repo.Migrations.CreateGameTeams do
  use Ecto.Migration

  def change do
    create table(:game_teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :team_score, :float, default: 0
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id)
      add :game_player_id, references(:game_players, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:game_teams, [:game_id])
    create index(:game_teams, [:game_player_id])
  end
end
