defmodule Reviewq.ReviewCounter do
  import Ecto.Query
  alias Reviewq.Repo
  alias Reviewq.Review

  def pending do
    Repo.one(from r in Review, where: r.status == "Pending", select: count(1))
  end

  def approved_in_last_24_hours do
    status_in_last_24_hours "Approved"
  end

  def rejected_in_last_24_hours do
    status_in_last_24_hours "Rejected"
  end

  defp status_in_last_24_hours(status) do
    Repo.one from r in Review,
      where: r.status == ^status,
      where: fragment("inserted_at >= NOW() - '1 day'::INTERVAL"),
      select: count(1)
  end
end
