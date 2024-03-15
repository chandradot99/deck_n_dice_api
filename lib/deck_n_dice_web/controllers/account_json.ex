defmodule DeckNDiceWeb.AccountJSON do
  alias DeckNDice.Accounts.Account

  @doc """
  Renders a single account.
  """
  def show(%{account: account, token: token}) do
    IO.inspect(account, label: "account")
    IO.inspect(token, label: "token")

    %{data: data(account, token)}
  end

  defp data(%Account{} = account, token) do
    %{
      id: account.id,
      username: account.username,
      token: token
    }
  end
end
