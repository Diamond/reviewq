defmodule Reviewq.Repo.Migrations.CreateReview do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :subject, :string
      add :description, :text
      add :tracker_link, :string
      add :github_link, :string
      add :status, :string
      add :requested_by, :string
      add :reviewed_by, :string

      timestamps
    end

  end
end
