# Generated by `mix grpc.gen.server`.
# Please implement all functions.
defmodule Question.QuestionService.Server do
  use GRPC.Server, service: Question.QuestionService.Service

  def question_call(question_request, _stream) do
    Question.QuestionResponse.new(question: ["what is 5 times 2 ?", "what is 4 minus 1 ?", "what is 7 plus 8 ?"])
  end

end
