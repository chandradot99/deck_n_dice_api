defmodule DeckNDice.GameResult do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_results" do
    field :winner_type, :string
    field :winner_player_id, :binary_id
    field :winner_team_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_result, attrs) do
    game_result
    |> cast(attrs, [:winner_type])
    |> validate_required([:winner_type])
  end
end
