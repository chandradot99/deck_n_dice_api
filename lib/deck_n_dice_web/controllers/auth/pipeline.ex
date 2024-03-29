defmodule DeckNDiceWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :deck_n_dice,
    module: DeckNDiceWeb.Auth.Guardian,
    error_handler: DeckNDiceWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
