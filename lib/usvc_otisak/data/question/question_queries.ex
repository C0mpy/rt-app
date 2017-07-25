defmodule UsvcOtisak.QuestionQueries do
  import Ecto.Query

  alias UsvcOtisak.{Repo, Question}

  def get_all() do
    Repo.all(from Question)
  end

  def get_by_id(id) do
    Repo.get(Question, id)
  end

  def create(question) do
    Repo.insert!(question)
  end

end
