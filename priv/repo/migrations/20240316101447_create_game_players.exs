defmodule DeckNDice.Repo.Migrations.CreateGamePlayers do
  use Ecto.Migration

  def change do
    create table(:game_players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :score, :float, default: 0
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id)
      add :player_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:game_players, [:game_id])
    create index(:game_players, [:player_id])
  end
end
