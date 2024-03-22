defmodule DeckNDice.Games.GamePlayer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_players" do
    field :score, :float
    field :player_identifier, :string
    belongs_to :game, DeckNDice.Games.Game
    belongs_to :player, DeckNDice.Users.User
    belongs_to :game_team, DeckNDice.Games.GameTeam, foreign_key: :team_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_players, attrs) do
    game_players
    |> cast(attrs, [:player_identifier, :game_id, :player_id])
    |> validate_required([:game_id, :player_id, :player_identifier])
  end
end
