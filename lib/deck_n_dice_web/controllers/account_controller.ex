defmodule DeckNDiceWeb.AccountController do
  use DeckNDiceWeb, :controller

  alias DeckNDiceWeb.Auth.Guardian
  alias DeckNDice.{Accounts, Accounts.Account, Users, Users.User}

  action_fallback DeckNDiceWeb.FallbackController

  def register(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(account),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      conn
      |> put_status(:created)
      |> render(:show, account: account, token: token)
    end
  end

  def sign_in(conn, %{"username" => username, "hash_password" => hash_password}) do
    case Guardian.authenticate(username, hash_password) do
      {:ok, account, token} ->
        conn = conn |> Plug.Conn.put_session(:account_id, account.id)

        IO.inspect(get_session(conn, :account_id), label: "account id")

        conn
        # |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:show, account: account, token: token)

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(json: DeckNDiceWeb.ErrorJSON)
        |> render(:"401")
    end
  end

  def sign_out(conn, %{}) do
    account =
      conn
      |> get_session(:account_id)
      |> Accounts.get_account!()

    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render(:show, account: account, token: nil)
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, "show.json", account: account, token: "")
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
