defmodule QuestionClient do
  @moduledoc """
  Documentation for ExClient.
  """

  def questions_get() do
    {:ok, channel} = GRPC.Stub.connect("localhost:50051")
    IO.puts(inspect(channel))
    questions_get(:channel, channel)
  end
  def questions_get(:channel, channel) do
    request  = Question.QuestionRequest.new()
    IO.puts(inspect(request))
    questions_get(:request, channel, request)
  end
  def questions_get(:request, channel, request) do
    channel |> Question.QuestionService.Stub.question_call(request)
  end

end
