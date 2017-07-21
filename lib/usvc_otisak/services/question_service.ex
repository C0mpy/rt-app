defmodule UsvcOtisak.QuestionService do
  @moduledoc """

  Module that acts as service for delegating calls to data persistence layers
  Provides functions for fetching all questions and giving answers to them
  """

  def get_questions() do
    UsvcOtisak.QuestionData.get_questions()
  end

  def add_answer(question_id, answer, username) do

    user_id = UsvcOtisak.UserData.get_user_id(username)

    true_answer = UsvcOtisak.AnswerData.get_answer(question_id)
    if true_answer == answer do
      UsvcOtisak.ScoreData.true_answer(user_id)
    else
      UsvcOtisak.ScoreData.false_answer(user_id)
    end

  end

end
