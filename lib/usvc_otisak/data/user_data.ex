defmodule UsvcOtisak.UserData do
  @moduledoc """

  Module for persisting all registered users 
  """
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, []}
  end

  def get_users() do
    GenServer.call(__MODULE__, {:get_users})
  end

  def get_user_id(username) do
    GenServer.call(__MODULE__, {:get_user_id, username})
  end

  def register_user(username) do
    GenServer.call(__MODULE__, {:register_user, username})
  end

  def remove_all_users() do
    GenServer.call(__MODULE__, {:remove_all_users})
  end



  def handle_call({:get_users}, _, state) do
    {:reply, state, state}
  end

  def handle_call({:register_user, username}, _, state) do
    state = [username | state]
    {:reply, state, state}
  end

  def handle_call({:get_user_id, username}, _, state) do
    user_id = Enum.find_index(state, fn(x) -> x == username end)
    {:reply, user_id, state}
  end

  def handle_call({:remove_all_users}, _, state) do
    {:reply, "no more users", []}
  end

end
