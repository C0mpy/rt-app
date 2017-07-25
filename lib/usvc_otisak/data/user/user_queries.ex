defmodule UsvcOtisak.UserQueries do
  import Ecto.Query

  alias UsvcOtisak.{Repo, User}

  def get_all() do
    Repo.all(from User)
  end

  def create(user) do
    Repo.insert!(user)
  end

  def get_by_username(username) do
    Repo.one(from u in User, where: u.username == ^username)
  end

  def get_score(username) do
    Repo.one(from u in User, select: u.score, where: u.username == ^username)
  end

  def set_score(username, value) do
    from(u in User, where: u.username == ^username)
    |> Repo.update_all(set: [score: value])
  end

end
