defmodule UsvcOtisak.UserService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching data concerning a user
  """


  def get_users() do
    UsvcOtisak.UserQueries.get_all()
  end

  def register_user(username) do
    UsvcOtisak.UserQueries.get_by_username(username)
    UsvcOtisak.UserQueries.create(UsvcOtisak.User.changeset(%UsvcOtisak.User{}, %{username: username, score: 0}))
  end

  def get_score(username) do
    if UsvcOtisak.UserQueries.get_by_username(username) != nil do
      UsvcOtisak.UserQueries.get_score(username)
    else
      "username doesn't exist, register fist"
    end
  end

  def remove_all_data() do
    UsvcOtisak.UserData.remove_all_users()
    UsvcOtisak.ScoreData.remove_all_scores()
  end

end
