defmodule Reviewq.PageController do
  use Reviewq.Web, :controller
  alias Reviewq.ReviewCounter

  def index(conn, _params) do
    render conn, "index.html", pending: ReviewCounter.pending, approved: ReviewCounter.approved_in_last_24_hours, rejected: ReviewCounter.rejected_in_last_24_hours
  end
end
