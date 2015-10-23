defmodule Reviewq.ReviewController do
  use Reviewq.Web, :controller

  alias Reviewq.Review

  plug :scrub_params, "review" when action in [:create, :update]

  def index(conn, %{"status" => status}) do
    reviews = Repo.all(from r in Review, where: r.status == ^status, order_by: [desc: :inserted_at])
    render(conn, "index.html", reviews: reviews, status: status)
  end

  def index(conn, _params) do
    reviews = Repo.all(from r in Review, order_by: [desc: :inserted_at])
    render(conn, "index.html", reviews: reviews, status: "All")
  end

  def new(conn, _params) do
    changeset = Review.changeset(%Review{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"review" => review_params}) do
    changeset = Review.changeset(%Review{}, review_params)

    case Repo.insert(changeset) do
      {:ok, _review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: review_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Repo.get!(Review, id)
    render(conn, "show.html", review: review)
  end

  def edit(conn, %{"id" => id}) do
    review = Repo.get!(Review, id)
    changeset = Review.changeset(review)
    render(conn, "edit.html", review: review, changeset: changeset)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Repo.get!(Review, id)
    changeset = Review.changeset(review, review_params)

    case Repo.update(changeset) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: review_path(conn, :show, review))
      {:error, changeset} ->
        render(conn, "edit.html", review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Repo.get!(Review, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(review)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: review_path(conn, :index))
  end
end
