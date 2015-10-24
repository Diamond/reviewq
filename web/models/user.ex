defmodule Reviewq.User do
  use Reviewq.Web, :model

  schema "users" do
    field :username, :string
    field :password_digest, :string
    field :score, :integer, default: 0
    field :admin, :boolean, default: false
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(username admin password password_confirmation score)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_password
  end

  defp hash_password(model) do
    if password = get_change(model, :password) do
      model
      |> put_change(:password_digest, Comeonin.Bcrypt.hashpwsalt(password))
    else
      model
    end
  end
end
