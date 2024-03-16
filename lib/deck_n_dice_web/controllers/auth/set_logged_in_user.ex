defmodule DeckNDiceWeb.Auth.SetLoggedInUser do
  alias DeckNDice.Users
  import Plug.Conn

  def init(_options) do
  end

  def call(conn, _options) do
    if conn.assigns[:logged_in_user] do
      conn
    else
      account_id = get_session(conn, :account_id)
      user = Users.get_user_by_account(account_id)

      cond do
        account_id && user -> assign(conn, :logged_in_user, user)
        true -> assign(conn, :logged_in_user, nil)
      end
    end
  end
end
