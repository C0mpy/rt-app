defmodule QuestionServerTest do
  use ExUnit.Case

  test "service should provide expected values" do
    response = Question.QuestionService.Server.question_call(Question.QuestionRequest.new(), nil)
    questions = response.question
    question1 = Enum.at(questions, 0)
    question2 = Enum.at(questions, 1)
    question3 = Enum.at(questions, 2)
    assert question1 == "what is 5 times 2 ?"
    assert question2 == "what is 4 minus 1 ?"
    assert question3 == "what is 7 plus 8 ?"
  end
end
