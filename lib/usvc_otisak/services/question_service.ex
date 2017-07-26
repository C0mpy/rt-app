defmodule UsvcOtisak.QuestionService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching all questions and giving answers to them
  """

  def get_questions() do
    UsvcOtisak.QuestionData.get_questions()
  end

  def add_answer(username, question_id, answer) do

    if UsvcOtisak.UserQueries.get_by_username(username) != nil do
      true_answer = UsvcOtisak.AnswerQueries.get_by_id(question_id)
      current_score = UsvcOtisak.UserQueries.get_score(username)
      if true_answer.data == answer do
        UsvcOtisak.UserQueries.set_score(username, current_score + 1)
        {:ok, "correct answer!"}
      else
        UsvcOtisak.UserQueries.set_score(username, current_score - 1)
        {:ok, "false answer!"}
      end
    else
      {:error, "username doesn't exist, register fist"}
    end

  end

end
