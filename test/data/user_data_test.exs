defmodule UsvcOtisakTests.UserData do
  use ExUnit.Case
  import UsvcOtisak.UserData

  @tag :genserver
  test "register_user" do
    assert [] = get_users()
    register_user("nemanja")
    assert ["nemanja"] = get_users()
  end

end
