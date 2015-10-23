defmodule Reviewq.PageControllerTest do
  use Reviewq.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to the Teladoc Code Review Queue!"
  end
end
