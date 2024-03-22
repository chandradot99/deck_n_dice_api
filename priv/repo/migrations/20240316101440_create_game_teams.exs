defmodule DeckNDice.Repo.Migrations.CreateGameTeams do
  use Ecto.Migration

  def change do
    create table(:game_teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :team_score, :float, default: 0
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:game_teams, [:game_id])
  end
end
