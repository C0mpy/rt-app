defmodule UsvcOtisak.UserService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching data concerning a user
  """
  import UsvcOtisak.Validate

  def get_users() do
    UsvcOtisak.UserQueries.get_all()
  end

  def register_user(username) do
    with {:error, _} <- validate_user_exists(username),
         {:ok, _} <- UsvcOtisak.UserQueries.create(UsvcOtisak.User.changeset(%UsvcOtisak.User{}, %{username: username, score: 0}))
    do
      {:ok, "user successfully registered\n"}
    else
      _ -> {:error, "username with value '#{username}' already taken\n"}
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
