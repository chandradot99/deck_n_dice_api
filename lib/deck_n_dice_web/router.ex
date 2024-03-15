defmodule DeckNDiceWeb.Router do
  use DeckNDiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug DeckNDiceWeb.Auth.Pipeline
    plug DeckNDiceWeb.Auth.SetAccount
  end

  scope "/api", DeckNDiceWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/register", AccountController, :register
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", DeckNDiceWeb do
    pipe_through [:api, :auth]
    get "/accounts/:id", AccountController, :show
  end
end
