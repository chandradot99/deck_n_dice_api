defmodule DeckNDice.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeckNDice.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        hash_password: "some hash_password",
        username: "some username"
      })
      |> DeckNDice.Accounts.create_account()

    account
  end
end
