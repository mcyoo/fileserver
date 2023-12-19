defmodule Example.PersonRepo do
  alias Example.Person
  alias Example.Repo

  def get_user(id) do
    Repo.get(Person, id)
  end

  def update_user(%Person{} = user, params) do
    user
    |> Person.changeset(params)
    |> Repo.update()
  end

  def sign_up(params) do
    %Person{}
    |> Person.changeset(params)
    |> Repo.insert()
  end

  def delete_user(%Person{} = user) do
    Repo.delete(user)
  end
end
