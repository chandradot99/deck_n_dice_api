defmodule DeckNDice.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :status, :string
      add :min_players, :integer, default: 1
      add :max_players, :integer, default: 20
      add :is_team_game, :boolean, default: false
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime
      add :created_by, references(:users, on_delete: :nothing, type: :binary_id)
      add :game_data, :map

      timestamps(type: :utc_datetime)
    end

    create index(:games, [:created_by, :type, :status])
  end
end
