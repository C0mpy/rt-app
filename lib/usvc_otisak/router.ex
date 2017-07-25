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
      UsvcOtisak.UserService.register_user(username)
      send_resp(conn, 200, "user successfully registered")
    end
  end

  get "/question" do
    send_resp(conn, 200, inspect(UsvcOtisak.QuestionQueries.get_all()))
  end

  post "/answer" do
    question_id = Map.get(conn.params, "question_id")
    answer = Map.get(conn.params, "answer")
    username = Map.get(conn.params, "username")

    if question_id == nil || answer == nil || username == nil || username == "" do
      send_resp(conn, 404, "bad parameters")
    else
      question_id =
      if String.valid?(question_id) do
        String.to_integer(question_id)
      end
      answer =
      if String.valid?(answer) do
        String.to_integer(answer)
      end
      result = UsvcOtisak.QuestionService.add_answer(question_id, answer, username)
      send_resp(conn, 200, "#{result}\n")
    end
  end

  get "/score" do
    username = conn.query_params["username"]
    if username == nil || username == "" do
      send_resp(conn, 404, "bad parameters")
    else
      result = UsvcOtisak.UserService.get_score(conn.query_params["username"])
      IO.puts(inspect(result))
      send_resp(conn, 200, "your score is: #{result}\n")
    end
  end

  get _ do
    send_resp(conn, 404, "bad path")
  end

  post _ do
    send_resp(conn, 404, "bad path")
  end

end
