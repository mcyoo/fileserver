defmodule Example.Post do
  use Ecto.Schema

  import Ecto.Changeset

  schema "posts" do
    field(:title, :string)
    field(:content, :string)
    field(:like_count, :integer, default: 0)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :content, :like_count])
    |> validate_required([:title, :content])
    #|> validate_length(:name, min: 2)
  end
end
