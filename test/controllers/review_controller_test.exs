defmodule Reviewq.ReviewControllerTest do
  use Reviewq.ConnCase

  alias Reviewq.Review
  @valid_attrs %{description: "some content", github_link: "some content", requested_by: "some content", reviewed_by: "some content", status: "Pending", subject: "Pending Review", tracker_link: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries with a pending status", %{conn: conn} do
    review = Repo.insert!(Review.changeset(%Review{}, @valid_attrs))
    conn = get conn, review_path(conn, :index, %{"status" => "Pending"})
    assert html_response(conn, 200) =~ review.subject
  end

  test "index does not include pending reviews when requesting Approved" do
    review = Repo.insert!(Review.changeset(%Review{}, @valid_attrs))
    conn = get conn, review_path(conn, :index, %{"status" => "Approved"})
    refute html_response(conn, 200) =~ review.subject
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, review_path(conn, :index)
    assert html_response(conn, 200) =~ "Code Reviews"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, review_path(conn, :new)
    assert html_response(conn, 200) =~ "New review"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, review_path(conn, :create), review: @valid_attrs
    assert redirected_to(conn) == review_path(conn, :index)
    assert Repo.get_by(Review, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, review_path(conn, :create), review: @invalid_attrs
    assert html_response(conn, 200) =~ "New review"
  end

  test "shows chosen resource", %{conn: conn} do
    review = Repo.insert!(Review.changeset(%Review{}, @valid_attrs))
    conn = get conn, review_path(conn, :show, review)
    assert html_response(conn, 200) =~ review.subject
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, review_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = get conn, review_path(conn, :edit, review)
    assert html_response(conn, 200) =~ "Edit review"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = put conn, review_path(conn, :update, review), review: @valid_attrs
    assert redirected_to(conn) == review_path(conn, :show, review)
    assert Repo.get_by(Review, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = put conn, review_path(conn, :update, review), review: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit review"
  end

  test "deletes chosen resource", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = delete conn, review_path(conn, :delete, review)
    assert redirected_to(conn) == review_path(conn, :index)
    refute Repo.get(Review, review.id)
  end
end
