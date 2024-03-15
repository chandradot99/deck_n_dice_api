defmodule DeckNDiceWeb.Router do
  use DeckNDiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug DeckNDiceWeb.Auth.Pipeline
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
