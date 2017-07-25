defmodule UsvcOtisak.AnswerQueries do
  import Ecto.Query

  alias UsvcOtisak.{Repo, Answer}

  def get_all() do
    Repo.all(from Answer)
  end

  def get_by_id(id) do
    Repo.get(Answer, id)
  end

  def create(answer) do
    Repo.insert!(answer)
  end

end
