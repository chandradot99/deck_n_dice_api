defmodule DeckNDice.GameTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_teams" do
    field :name, :string
    field :game_id, :binary_id
    field :game_player_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_team, attrs) do
    game_team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
