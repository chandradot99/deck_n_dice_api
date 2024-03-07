defmodule DeckNDice.Repo do
  use Ecto.Repo,
    otp_app: :deck_n_dice,
    adapter: Ecto.Adapters.Postgres
end
