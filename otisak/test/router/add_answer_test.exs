defmodule Example.AddAnswerTest do
  use ExUnit.Case
  use Plug.Test

  alias UsvcOtisak.Router

  @opts Router.init([])

  test "user forgot to send his username, should fail" do

    params = Poison.encode!(%{question_id: "1", answer: "55"})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user forgot to send his answer, should fail" do

    params = Poison.encode!(%{username: "user", question_id: "1"})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user forgot to send question_id, should fail" do

    params = Poison.encode!(%{username: "user", answer: "1"})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user sent wrong username, should fail" do

    params = Poison.encode!(%{username: "wrong_username", question_id: "1", answer: "1"})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user sent question_id as integer, should pass" do

    params = Poison.encode!(%{username: "nemanja", question_id: 1, answer: 1})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200

  end

  test "user sent random string as question_id, should fail" do

    params = Poison.encode!(%{username: "nemanja", question_id: "random_string", answer: "1"})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

  test "user sent answer as integer, should pass" do

    params = Poison.encode!(%{username: "nemanja", question_id: 1, answer: 1})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200

  end

  test "user sent random string as answer, should fail" do

    params = Poison.encode!(%{username: "nemanja", question_id: "random_string", answer: "1"})
    conn = conn(:post, "/answer", params)
           |> put_req_header("content-type", "application/json")
           |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404

  end

end
