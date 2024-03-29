defmodule DeckNDiceWeb.Auth.SetLoggedInUser do
  alias DeckNDice.Repo
  import Plug.Conn
  alias DeckNDiceWeb.Auth.Guardian

  def init(_options) do
  end

  def call(conn, _options) do
    account =
      conn
      |> Guardian.Plug.current_resource()
      |> Repo.preload([:user])

    assign(conn, :logged_in_user, account.user)
  end
end
