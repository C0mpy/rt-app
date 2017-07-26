defmodule Example.GetScoreTest do
  use ExUnit.Case
  use Plug.Test

  alias UsvcOtisak.Router

  @opts Router.init([])

  test "user forgot to send his username, should fail" do

    conn = conn(:get, "/score")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user provided invalid username, should fail" do

    conn = conn(:get, "/score?username=invalid_username")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user provided valid username, should pass" do

    conn = conn(:get, "/score?username=nemanja")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200

  end

end
