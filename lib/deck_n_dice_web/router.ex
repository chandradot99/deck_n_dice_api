defmodule DeckNDiceWeb.Router do
  use DeckNDiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DeckNDiceWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/register", AccountController, :register
    post "/accounts/sign_in", AccountController, :sign_in
  end
end
