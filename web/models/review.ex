defmodule Reviewq.Review do
  use Reviewq.Web, :model

  schema "reviews" do
    field :subject, :string
    field :description, :string
    field :tracker_link, :string
    field :github_link, :string
    field :status, :string
    field :requested_by, :string
    field :reviewed_by, :string

    timestamps
  end

  @required_fields ~w(subject github_link status requested_by)
  @optional_fields ~w(tracker_link reviewed_by description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
