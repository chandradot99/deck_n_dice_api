defmodule DeckNDiceWeb.DefaultController do
  use DeckNDiceWeb, :controller

  def index(conn, _params) do
    text(conn, "Deck N Dice API is LIVE - #{Mix.env()}")
  end
end
