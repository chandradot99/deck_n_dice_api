defmodule DeckNDiceWeb.GameController do
  alias DeckNDice.Games
  alias DeckNDice.Games.Game
  use DeckNDiceWeb, :controller

  action_fallback DeckNDiceWeb.FallbackController

  def create(conn, %{"game" => %{"playAs" => playAs} = game_params}) do
    case Games.create_game(game_params) do
      {:ok, game} ->
        Games.add_game_player(game, %{
          game_id: game.id,
          player_id: conn.assigns[:logged_in_user].id,
          player_identifier: playAs
        })

        conn
        |> put_status(:created)
        |> render(:show, game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    test = Games.get_game(id)

    IO.inspect(test, label: "Game")

    case Games.get_game(id) do
      %Game{} = game ->
        render(conn, :show, game: game)

      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(json: DeckNDiceWeb.ErrorJSON)
        |> render(:"404")
    end
  end

  def join_game(conn, %{"game_id" => game_id}) do
    user = conn.assigns[:logged_in_user]

    game = Games.get_game(game_id)
    Games.add_game_player(game, %{player_id: user.id})

    send_resp(conn, :no_content, "game joined successfully")
  end
end
