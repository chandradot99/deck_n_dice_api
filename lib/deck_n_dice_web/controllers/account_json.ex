defmodule DeckNDiceWeb.AccountJSON do
  alias DeckNDice.Accounts.Account
  alias DeckNDice.Users.User

  @doc """
  Renders a single account.
  """

  def show(%{account: account, token: token}) do
    %{data: data(account, token)}
  end

  defp render_user(%Ecto.Association.NotLoaded{}), do: nil

  defp render_user(%User{} = user) do
    %{
      id: user.id,
      name: user.full_name,
      email: user.email,
      gender: user.gender,
      biography: user.biography,
      dob: user.dob
    }
  end

  defp data(%Account{} = account, token) do
    %{
      id: account.id,
      username: account.username,
      token: token,
      user: render_user(account.user)
    }
  end
end
