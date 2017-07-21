defmodule UsvcOtisak.UserService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching data concerning a user
  """


  def get_users() do
    UsvcOtisak.UserData.get_users()
  end

  def register_user(username) do
    UsvcOtisak.UserData.register_user(username)
    UsvcOtisak.ScoreData.new_score()
  end

  def get_score(username) do
    user_id = UsvcOtisak.UserData.get_user_id(username)
    UsvcOtisak.ScoreData.get_score(user_id)
  end

  def remove_all_data() do
    UsvcOtisak.UserData.remove_all_users()
    UsvcOtisak.ScoreData.remove_all_scores()
  end

end
