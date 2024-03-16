defmodule DeckNDiceWeb.GameController do
  alias DeckNDice.Games
  use DeckNDiceWeb, :controller

  action_fallback DeckNDiceWeb.FallbackController

  def create(conn, %{"game" => game_params}) do
    case Games.create_game(game_params) do
      {:ok, game} ->
        conn
        |> put_status(:created)
        |> render(:show, game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, :show, game: game)
  end

  def join_game(conn, %{"game_id" => game_id}) do
    user = conn.assigns[:logged_in_user]

    game = Games.get_game!(game_id)
    Games.add_game_player(game, %{player_id: user.id})

    send_resp(conn, :no_content, "game joined successfully")
  end
end
