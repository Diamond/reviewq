defmodule Reviewq.ReviewView do
  use Reviewq.Web, :view

  def valid_statuses do
    ~w(Pending Approved Rejected Closed)
  end
end
