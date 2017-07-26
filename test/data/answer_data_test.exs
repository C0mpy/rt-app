defmodule UsvcOtisakTests.AnswerData do
  use ExUnit.Case
  import UsvcOtisak.AnswerData

  @tag :genserver
  test "get correct answer" do
    assert 2 == get_answer(0)
    assert 3 == get_answer(1)
    assert 15 == get_answer(2)
  end

end
