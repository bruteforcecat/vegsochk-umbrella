defmodule VegsochkWeb.Author.PageController do
  use VegsochkWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
