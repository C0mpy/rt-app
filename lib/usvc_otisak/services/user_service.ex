defmodule UsvcOtisak.UserService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching data concerning a user
  """


  def get_users() do
    UsvcOtisak.UserQueries.get_all()
  end

  def register_user(username) do
    if UsvcOtisak.UserQueries.get_by_username(username) != nil do
      {:error, "parameter 'username' with value '#{username}' already taken\n"}
    else
      :ok
    end
  end

  def get_score(username) do
    if UsvcOtisak.UserQueries.get_by_username(username) != nil do
      {:ok, "your score is: #{UsvcOtisak.UserQueries.get_score(username)}\n"}
    else
      {:error, "username doesn't exist, register fist\n"}
    end
  end

end
