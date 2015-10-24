defmodule Reviewq.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_digest, :string
      add :score, :integer
      add :admin, :boolean, default: false

      timestamps
    end

  end
end
