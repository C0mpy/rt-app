defmodule UsvcOtisak.ScoreData do
  @moduledoc """

  Module for persisting user's total score when answering questions from QuestionData module
  """

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, []}
  end

  def new_score() do
    GenServer.call(__MODULE__, {:new_score})
  end

  def get_score(user_id) do
    GenServer.call(__MODULE__, {:get_score, user_id})
  end

  def true_answer(user_id) do
    GenServer.call(__MODULE__, {:true_answer, user_id})
  end

  def false_answer(user_id) do
    GenServer.call(__MODULE__, {:false_answer, user_id})
  end

  def remove_all_scores() do
    GenServer.call(__MODULE__, {:remove_all_scores})
  end



  def handle_call({:new_score}, _, state) do
    {:reply, "ok", List.insert_at(state, 1, 0)}
  end

  def handle_call({:get_score, user_id}, _, state) do
    {:ok, score} = Enum.fetch(state, user_id)
    {:reply, score, state}
  end

  def handle_call({:true_answer, user_id}, _, state) do
    {:ok, score} = Enum.fetch(state, user_id)
    new_score = score + 1
    state = List.replace_at(state, user_id, new_score)
    {:reply, "score increased", state}
  end

  def handle_call({:false_answer, user_id}, _, state) do
    {:ok, score} = Enum.fetch(state, user_id)
    new_score = score - 1
    state = List.replace_at(state, user_id, new_score)
    {:reply, "score reduced", state}
  end

  def handle_call({:remove_all_scores}, _, state) do
    {:reply, "no more scores", []}
  end

end
