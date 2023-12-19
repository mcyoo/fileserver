defmodule Example.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: true
      add :content, :string, null: true
      add :like_count, :integer, default: 0
    end
  end
end
