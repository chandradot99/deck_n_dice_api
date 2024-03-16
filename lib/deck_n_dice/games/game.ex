defmodule DeckNDice.Games.Game do
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
    field :total_players, :integer
    field :finished_at, :utc_datetime
    field :game_data, :map
    belongs_to :user, DeckNDice.Users.User, foreign_key: :created_by
    has_many :game_players, DeckNDice.Games.GamePlayer
    has_many :game_teams, DeckNDice.Games.GameTeam
    has_one :game_result, DeckNDice.Games.GameTeam

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [
      :type,
      :status,
      :min_players,
      :max_players,
      :total_players,
      :started_at,
      :finished_at,
      :game_data,
      :user_id
    ])
    |> validate_required([:type, :status, :user_id])
  end
end
