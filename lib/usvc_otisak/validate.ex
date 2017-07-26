defmodule UsvcOtisak.Validate do

  def validate_username(username) do
    with false <- is_atom(username),
         false <- is_nil(username)
    do
      {:ok, username}
    else
      true -> {:error, "parameter 'username' must be provided\n"}
    end
  end

  def validate_question_id(question_id) do
    with false <- is_atom(question_id),
         false <- is_nil(question_id),
         true <- is_integer(question_id)
    do
      {:ok, question_id}
    else
      _ -> {:error, "invalid parameter 'question_id', it must be an integer\n"}
    end
  end

  def validate_answer(answer) do
    with false <- is_atom(answer),
         false <- is_nil(answer),
         true <- is_integer(answer)
    do
      {:ok, answer}
    else
      _ -> {:error, "invalid parameter 'answer', it must be an integer\n"}
    end
  end

end
