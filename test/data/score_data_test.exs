defmodule UsvcOtisakTests.ScoreData do
  use ExUnit.Case
  import UsvcOtisak.ScoreData

  describe "when user is registered" do

    setup do
      UsvcOtisak.UserService.register_user("nemanja")

      on_exit fn ->
        UsvcOtisak.UserService.remove_all_data()
      end
      :ok
    end

    @tag :genserver
    test "get initial score for a user" do
      assert 0 == get_score(0)
    end

    @tag :genserver
    test "user with id = 0 gives true answer" do
      true_answer(0)
      assert 1 = get_score(0)
    end

    @tag :genserver
    test "user with id = 0 gives false answer" do
      false_answer(0)
      assert -1 = get_score(0)
    end

  end


end
