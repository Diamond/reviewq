# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Reviewq.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Reviewq.Repo
alias Reviewq.User

%User{}
|> User.changeset(%{username: "admin", password: "test1234", password_confirmation: "test1234", admin: true})
|> Repo.insert!
