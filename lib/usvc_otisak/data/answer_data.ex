defmodule UsvcOtisak.AnswerData do
  @moduledoc """

  Module for persisting correct answers on questions from QuestionData module
  """

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, [2, 3, 15]}
  end

  def get_answer(question_id) do
    GenServer.call(__MODULE__, {:get_answer, question_id})
  end



  def handle_call({:get_answer, question_id}, _, state) do
    case Enum.fetch(state, question_id) do
      {:ok, answer} ->
        {:reply, answer, state}
      {:error, msg} ->
        {:reply, msg, state}
      end
  end

end
