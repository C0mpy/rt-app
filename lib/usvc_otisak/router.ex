defmodule UsvcOtisak.Router do
  import Plug.Conn
  require Logger
  use Plug.Router
  import UsvcOtisak.Validate

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
    with {:ok, username} <- Map.fetch(conn.params, "username"),
         username <- "#{username}",
         {:ok, _} <- UsvcOtisak.UserService.register_user(username)
    do
      send_resp(conn, 200, "user successfully registered\n")
    else
      :error -> send_resp(conn, 404, "parameter 'username' must be provided\n")
      {:error, reason} -> send_resp(conn, 404, reason)
    end
  end

  get "/question" do
    send_resp(conn, 200, inspect(UsvcOtisak.QuestionQueries.get_all()))
  end

  post "/answer" do
    with {:ok, username} <- validate_username(Map.get(conn.params, "username")),
         {:ok, question_id} <- validate_question_id(Map.get(conn.params, "question_id")),
         {:ok, answer} <- validate_answer(Map.get(conn.params, "answer")),
         {:ok, result} <- UsvcOtisak.QuestionService.add_answer(username, question_id, answer)
    do
      send_resp(conn, 200, result)
    else
      {:error, reason} -> send_resp(conn, 404, reason)
    end
  end

  get "/score" do
    with {:ok, username} <- validate_username(conn.query_params["username"]),
      {:ok, result} <- UsvcOtisak.UserService.get_score(username)
    do
      send_resp(conn, 200, result)
    else
      {:error, reason} -> send_resp(conn, 404, reason)
    end
  end

  match _ do
    send_resp(conn, 404, "bad path")
  end

end
