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
    send_resp(conn, 200, UsvcOtisak.UserService.register_user(Map.get(conn.params, "username")))
  end

  get "/question" do
    send_resp(conn, 200, inspect(UsvcOtisak.QuestionService.get_questions()))
  end

  post "/answer" do
    {question_id, _} = Integer.parse(Map.get(conn.params, "question_id"))
    {answer, _} = Integer.parse(Map.get(conn.params, "answer"))
    username = Map.get(conn.params, "username")
    send_resp(conn, 200, UsvcOtisak.QuestionService.add_answer(question_id, answer, username))
  end

  get "/score" do
    send_resp(conn, 200, UsvcOtisak.UserService.get_score(conn.query_params["username"]))
  end



end
