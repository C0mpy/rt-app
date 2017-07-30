defmodule UsvcOtisak.Repo.Migrations.AddQuestionTable do
  use Ecto.Migration

  def change do
    create table(:question) do
      add :data, :string
      add :answer_id, :integer
    end
  end
end
