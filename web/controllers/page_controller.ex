defmodule Reviewq.PageController do
  use Reviewq.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
