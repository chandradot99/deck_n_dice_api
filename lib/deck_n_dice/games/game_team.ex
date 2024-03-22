defmodule DeckNDice.Games.GameTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_teams" do
    field :name, :string
    field :team_score, :float
    belongs_to :game, DeckNDice.Games.Game
    has_many :game_players, DeckNDice.Games.GamePlayer, foreign_key: :team_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_team, attrs) do
    game_team
    |> cast(attrs, [:name, :game_id])
    |> validate_required([:name, :game_id])
  end
end
