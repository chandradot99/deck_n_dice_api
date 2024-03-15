defmodule DeckNDice.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeckNDice.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        biography: "some biography",
        dob: ~D[2024-03-14],
        email: "some email",
        full_name: "some full_name",
        gender: "some gender"
      })
      |> DeckNDice.Users.create_user()

    user
  end
end
