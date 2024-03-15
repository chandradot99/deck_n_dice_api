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
        conn
        |> put_status(:ok)
        |> render(:show, account: account, token: token)

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(json: DeckNDiceWeb.ErrorJSON)
        |> render(:"401")
    end
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
