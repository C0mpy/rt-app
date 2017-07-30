defmodule UsvcOtisak.QuestionService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching all questions and giving answers to them
  """
  import UsvcOtisak.Validate

  def get_questions() do
    result = QuestionClient.questions_get()
    IO.puts(inspect(result))
    result
  end

  def add_answer(username, question_id, answer) do

    with {:ok, user} <- validate_user_exists(username),
         {:ok, true_answer} <- validate_answer_exists(question_id),
         {:ok, result} <- validate_answer(answer, true_answer),
         {:ok, new_score} <- update_score(result, user.score)
    do
      UsvcOtisak.UserQueries.set_score(username, new_score)
      {:ok, "your answer has been recorded\n"}
    else
      {:error, reason} -> {:error, reason}
    end

  end

  def update_score(:true, current_score) do
    {:ok, current_score + 1}
  end

  def update_score(:false, current_score) do
    {:ok, current_score - 1}
  end

end
