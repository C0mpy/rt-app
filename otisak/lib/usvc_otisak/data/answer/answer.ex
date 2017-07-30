defmodule UsvcOtisak.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answer" do
    field :data, :integer
  end

  @required_fields ~w(data)a

  def changeset(question, params \\ %{}) do

    question
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)

  end
end
