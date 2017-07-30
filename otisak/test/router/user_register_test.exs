defmodule Example.UserRegisterTest do
  use ExUnit.Case
  use Plug.Test

  alias UsvcOtisak.Router

  @opts Router.init([])

  test "user tries to register with a valid username, he should succeed" do

    params = Poison.encode!(%{username: "valid_username"})
    conn = conn(:post, "/user", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200

  end

  test "user tries to register with already used but valid username, he should fail" do

    params = Poison.encode!(%{username: "nemanja"})
    conn = conn(:post, "/user", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user tries to register but forgot to provide username, he should fail" do

    conn = conn(:post, "/user")
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user tries to register with username of non-string type, he should succeed with provided username parsed as string" do

    conn = conn(:post, "/user", "{\"username\":1}")
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200

  end

end
