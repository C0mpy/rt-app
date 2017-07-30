defmodule UsvcOtisak.Repo.Migrations.AddAnswerTable do
  use Ecto.Migration

  def change do
    create table(:answer) do
      add :data, :integer
    end
  end

end
