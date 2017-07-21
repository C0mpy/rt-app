defmodule UsvcOtisakTests.QuestionData do
  use ExUnit.Case
  import UsvcOtisak.QuestionData

  test "get questions" do
    assert ["1 + 1", "2 + 1", "3 * 5"] = get_questions()
  end

end
