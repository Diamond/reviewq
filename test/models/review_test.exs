defmodule Reviewq.ReviewTest do
  use Reviewq.ModelCase

  alias Reviewq.Review

  @valid_attrs %{description: "some content", github_link: "some content", requested_by: "some content", reviewed_by: "some content", status: "some content", subject: "some content", tracker_link: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Review.changeset(%Review{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Review.changeset(%Review{}, @invalid_attrs)
    refute changeset.valid?
  end
end
