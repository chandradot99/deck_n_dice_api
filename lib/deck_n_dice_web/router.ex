defmodule DeckNDiceWeb.Router do
  use DeckNDiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DeckNDiceWeb do
    pipe_through :api
    get "/", DefaultController, :index
  end
end
