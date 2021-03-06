defmodule Vegsochk.CMS.Article do
  use Vegsochk.Data

  alias Vegsochk.CMS.{Article, Author, Tag}

  @required_fields ~w(title tldr body cover_image author_id is_draft)a
  schema "articles" do
    field :title, :string
    field :tldr, :string
    field :cover_image, :string
    field :body, :string
    field :slug, :string
    field :is_draft, :boolean

    belongs_to :author, Author
    many_to_many :tags, Tag, join_through: "articles_tags", on_delete: :delete_all
    timestamps()
  end

  def with_tag(query \\ __MODULE__, tag) do
    from q in query,
      join: c in assoc(q, :tags),
      where: c.id == ^tag.id
  end

  def with_slug(query \\ __MODULE__, slug) do
    from q in query,
      where: q.slug == ^slug
  end

  def with_author(query \\ __MODULE__, author) do
    from q in query,
      join: t in assoc(q, :tags),
      where: t.id == ^author.id
  end

  def exclude_draft(query) do
    from q in query,
    where: q.is_draft == false
  end

  def preload_author(query) do
    query |> Ecto.Query.preload(author: :user)
  end

  def preload_tags(query) do
    query |> Ecto.Query.preload(:tags)
  end

  @doc false
  def changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def auto_slug_changeset(%Article{} = article, attrs) do
    changeset = changeset(article, attrs)
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, String.downcase(title) |> String.replace(" ", "-"))
    else
      changeset
    end
  end
end

