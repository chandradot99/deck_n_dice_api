defmodule DeckNDiceWeb.UserControllerTest do
  use DeckNDiceWeb.ConnCase

  import DeckNDice.UsersFixtures

  alias DeckNDice.Users.User

  @create_attrs %{
    full_name: "some full_name",
    gender: "some gender",
    biography: "some biography",
    email: "some email",
    dob: ~D[2024-03-14]
  }
  @update_attrs %{
    full_name: "some updated full_name",
    gender: "some updated gender",
    biography: "some updated biography",
    email: "some updated email",
    dob: ~D[2024-03-15]
  }
  @invalid_attrs %{full_name: nil, gender: nil, biography: nil, email: nil, dob: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "biography" => "some biography",
               "dob" => "2024-03-14",
               "email" => "some email",
               "full_name" => "some full_name",
               "gender" => "some gender"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "biography" => "some updated biography",
               "dob" => "2024-03-15",
               "email" => "some updated email",
               "full_name" => "some updated full_name",
               "gender" => "some updated gender"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
