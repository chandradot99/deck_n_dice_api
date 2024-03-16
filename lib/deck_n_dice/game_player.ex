defmodule DeckNDice.GamePlayer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_players" do
    field :score, :integer
    field :game_id, :binary_id
    field :player_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game_players, attrs) do
    game_players
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
