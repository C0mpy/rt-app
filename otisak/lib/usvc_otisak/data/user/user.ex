defmodule UsvcOtisak.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :username, :string
    field :score, :integer
  end

  @required_fields ~w(username score)a

  def changeset(user, params \\ %{}) do

    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)

  end
end
