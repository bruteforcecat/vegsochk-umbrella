defmodule VegsochkWeb.Api.V1.ArticleView do
  use VegsochkWeb, :view

  alias Vegsochk.CMS.Article

  def render("show.json",
             %Article{
               id: id, title: title, tldr: tldr, body: body, is_draft: is_draft,
               tags: tags, cover_image: cover_image
             })
  do
    %{id: id,
      title: title,
      cover_image: cover_image,
      tldr: tldr,
      is_draft: is_draft,
      body: body,
      tag_ids: Enum.map(tags, &(&1.id))
    }
  end
end

