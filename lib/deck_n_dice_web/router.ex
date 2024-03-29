defmodule DeckNDiceWeb.Router do
  use DeckNDiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug DeckNDiceWeb.Auth.Pipeline
    plug DeckNDiceWeb.Auth.SetLoggedInUser
  end

  scope "/api", DeckNDiceWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/register", AccountController, :register
    post "/accounts/login", AccountController, :sign_in
    post "/accounts/verify_token", AccountController, :verify_token
  end

  scope "/api", DeckNDiceWeb do
    pipe_through [:api, :auth]
    get "/accounts/:id", AccountController, :show
    post "/accounts/sign_out", AccountController, :sign_out

    resources "/games", GameController, only: [:create, :show]
    get "/games/:game_id/join", GameController, :join_game
  end
end
