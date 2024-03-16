defmodule DeckNDice.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :full_name, :string
    field :gender, Ecto.Enum, values: [:male, :female, :other]
    field :biography, :string
    field :email, :string
    field :dob, :date
    belongs_to :account, DeckNDice.Accounts.Account
    has_many :games, DeckNDice.Games.Game, foreign_key: :created_by

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :full_name, :gender, :biography, :email, :dob])
    |> validate_required([:account_id])
  end
end
