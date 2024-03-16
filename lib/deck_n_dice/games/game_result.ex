defmodule DeckNDice.Games.GameResult do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_results" do
    field :winner_type, :string
    belongs_to :winner_player, DeckNDice.Games.GamePlayer
    belongs_to :winner_team, DeckNDice.Games.GameTeam

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_result, attrs) do
    game_result
    |> cast(attrs, [:winner_type, :winner_player_id, :winner_team_id])
    |> validate_required([:winner_type])
  end
end
