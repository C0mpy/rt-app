defmodule UsvcOtisak.QuestionData do
  @moduledoc """

  Module for persisting all questions users can give answers to
  """
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, ["1 + 1", "2 + 1", "3 * 5"]}
  end

  def get_questions() do
    GenServer.call(__MODULE__, {:get_questions})
  end



  def handle_call({:get_questions}, _, state) do
    {:reply, state, state}
  end

end
