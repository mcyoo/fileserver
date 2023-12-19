defmodule Example.PostRepo do
  alias Example.Post
  alias Example.Repo

  def get_post(id) do
    Repo.get(Post, id)
  end

  def update_post(%Post{} = post, params) do
    post
    |> Post.changeset(params)
    |> Repo.update()
  end

  def make_post(params) do
    %Post{}
    |> Post.changeset(params)
    |> Repo.insert()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end
end
