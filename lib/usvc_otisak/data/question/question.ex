defmodule UsvcOtisak.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question" do
    field :data, :string
    field :answer_id, :integer
  end

  @required_fields ~w(data answer_id)a

  def changeset(question, params \\ %{}) do

    question
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)

  end
end
