defmodule UsvcOtisak.Router do
  import Plug.Conn
  require Logger
  use Plug.Router


  plug Plug.Logger
  plug :match
  plug Plug.Parsers, parsers: [:json],
                     pass:  ["application/json"],
                     json_decoder: Poison
  plug :dispatch


  get "/user" do
    send_resp(conn, 200, inspect(UsvcOtisak.UserService.get_users()))
  end

  post "/user" do
    username = Map.get(conn.params, "username")
    if username == nil || username == "" do
      send_resp(conn, 404, "bad parameters")
    else
      send_resp(conn, 200, UsvcOtisak.UserService.register_user(username))
    end
  end

  get "/question" do
    send_resp(conn, 200, inspect(UsvcOtisak.QuestionService.get_questions()))
  end

  post "/answer" do
    question_id = Map.get(conn.params, "question_id")
    answer = Map.get(conn.params, "answer")
    username = Map.get(conn.params, "username")

    if question_id == nil || answer == nil || username == nil || username == "" do
      send_resp(conn, 404, "bad parameters")
    else
      {question_id, _} = Integer.parse(question_id)
      {answer, _} = Integer.parse(answer)
      send_resp(conn, 200, UsvcOtisak.QuestionService.add_answer(question_id, answer, username))
    end

  end

  get "/score" do
    username = conn.query_params["username"]
    if username == nil || username == "" do
      send_resp(conn, 404, "bad parameters")
    else
      send_resp(conn, 200, UsvcOtisak.UserService.get_score(conn.query_params["username"]))
    end
  end

  get _ do
    send_resp(conn, 404, "bad path")
  end

  post _ do
    send_resp(conn, 404, "bad path")
  end

end
