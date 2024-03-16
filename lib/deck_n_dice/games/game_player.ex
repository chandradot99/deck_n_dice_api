defmodule DeckNDice.Games.GamePlayer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_players" do
    field :score, :float
    belongs_to :game, DeckNDice.Games.Game
    belongs_to :player, DeckNDice.Users.User
    has_one :game_team, DeckNDice.Games.GameTeam

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_players, attrs) do
    game_players
    |> cast(attrs, [:score, :game_id, :player_id])
    |> validate_required([:game_id, :player_id])
  end
end
