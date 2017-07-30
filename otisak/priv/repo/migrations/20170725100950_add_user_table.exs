defmodule UsvcOtisak.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :username, :string
      add :score, :integer
    end
  end
end
