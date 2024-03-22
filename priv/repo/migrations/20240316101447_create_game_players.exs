defmodule DeckNDice.Repo.Migrations.CreateGamePlayers do
  use Ecto.Migration

  def change do
    create table(:game_players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :score, :float, default: 0
      add :player_identifier, :string, null: false
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id), null: false
      add :player_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :team_id, references(:game_teams, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:game_players, [:game_id])
    create index(:game_players, [:player_id])
    create index(:game_players, [:team_id])
  end
end
