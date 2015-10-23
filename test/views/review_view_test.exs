defmodule Reviewq.ReviewViewTest do
  alias Reviewq.ReviewView
  use Reviewq.ConnCase, async: true

  test "valid_statuses returns a list of status" do
    assert [hd|_] = ReviewView.valid_statuses
  end
end
