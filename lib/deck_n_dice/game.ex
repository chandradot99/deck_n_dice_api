defmodule DeckNDice.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "games" do
    field :status, Ecto.Enum, values: [:created, :in_progess, :finished, :abandoned]
    field :type, Ecto.Enum, values: [:chess]
    field :started_at, :utc_datetime
    field :min_players, :integer
    field :max_players, :integer
    field :finished_at, :utc_datetime
    field :created_by, :binary_id
    field :game_data, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:type, :status, :min_players, :max_players, :started_at, :finished_at])
    |> validate_required([:type, :status, :min_players, :max_players, :started_at, :finished_at])
  end
end
