defmodule VegsochkWeb.PageController do
  use VegsochkWeb, :controller
  
  alias Vegsochk.CMS

  def index(conn, _params) do
    {first_article, rest_articles} = case CMS.list_latest_articles(3) do
      [] -> {nil, []}
      [first | rest] -> {first, rest}
    end
    news_items = CMS.list_latest_news_items(5)

    render conn, "index.html", first_article: first_article,
      rest_articles: rest_articles, news_items: news_items
  end

  def show(conn, %{"page_name" => page_name}) when page_name in ["about_us", "health"] do
    conn
    |> render("#{page_name}.html")
  end


  def show(conn, %{"page_name" => page_name}) do
    conn
    |> Phoenix.Controller.put_layout("article.html")
    |> render("#{page_name}.html")
  end

  def logout_success(conn, _params) do
    render conn, "logout_success.html"
  end
end
