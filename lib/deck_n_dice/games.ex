defmodule DeckNDice.Games do
  @moduledoc """
  The Games context.
  """
  import Ecto.Query, warn: false
  alias DeckNDice.Games.{GamePlayer, Game}
  alias DeckNDice.Repo

  @doc """
  Gets a single Game
  """
  def get_game(id) do
    Repo.get(Game, id)

    query =
      from game in Game,
        inner_join: time_setting in assoc(game, :game_time_control_setting),
        left_join: game_players in assoc(game, :game_players),
        left_join: player in assoc(game_players, :player),
        where: game.id == ^id,
        preload: [
          game_time_control_setting: time_setting,
          game_players: {game_players, player: player}
        ]

    Repo.one(query)
  end

  @doc """
  Creates a Game

  ## Examples

    iex> create_game(%{type: "chess", status: "created"})
    {:ok, %Game{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets all game players

  ## Examples

    iex> get_game_players()
  """
  def get_game_players(game_id) do
    query =
      from gp in GamePlayer,
        join: p in assoc(gp, :player),
        where: gp.game_id == ^game_id,
        preload: [player: p]

    Repo.all(query)
  end

  @doc """
  Adds a player to a game

  ## Examples

    iex> add_game_player(game, %{game_id: 1, user_id: 1})
    {:ok, %GamePlayer{}}

  """
  def add_game_player(game, attrs \\ %{}) do
    game
    |> Ecto.build_assoc(:game_players)
    |> GamePlayer.changeset(attrs)
    |> Repo.insert()
  end
end
