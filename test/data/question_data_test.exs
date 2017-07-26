defmodule UsvcOtisakTests.QuestionData do
  use ExUnit.Case
  import UsvcOtisak.QuestionData

  @tag :genserver
  test "get questions" do
    assert ["1 + 1", "2 + 1", "3 * 5"] = get_questions()
  end

end
