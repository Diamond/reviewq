defmodule Reviewq.ReviewCounterTest do
  use Reviewq.ModelCase
  alias Reviewq.Review
  alias Reviewq.ReviewCounter

  @valid_attrs %{description: "some content", github_link: "some content", requested_by: "some content", reviewed_by: "some content", status: "some content", subject: "some content", tracker_link: "some content"}

  setup do
    Repo.insert!(Review.changeset(%Review{}, Map.put(@valid_attrs, :status, "Pending")))
    Repo.insert!(Review.changeset(%Review{}, Map.put(@valid_attrs, :status, "Pending")))

    Repo.insert!(Review.changeset(%Review{}, Map.put(@valid_attrs, :status, "Approved")))

    Repo.insert!(Review.changeset(%Review{}, Map.put(@valid_attrs, :status, "Rejected")))
    Repo.insert!(Review.changeset(%Review{}, Map.put(@valid_attrs, :status, "Rejected")))
    Repo.insert!(Review.changeset(%Review{}, Map.put(@valid_attrs, :status, "Rejected")))
    {:ok, %{}}
  end

  test "returns correct number of pending reviews" do
    assert ReviewCounter.pending == 2
  end

  test "returns correct number of approved reviews" do
    assert ReviewCounter.approved_in_last_24_hours == 1
  end

  test "returns correct number of rejected reviews" do
    assert ReviewCounter.rejected_in_last_24_hours == 3
  end
end
