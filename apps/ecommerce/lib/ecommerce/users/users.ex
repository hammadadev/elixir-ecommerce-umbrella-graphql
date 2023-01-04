defmodule Ecommerce.Users.Users do
  alias Ecommerce.Users.User
  alias Ecommerce.Repo

  def find_user(id) do
    case Repo.get(User, id) do
      nil ->
        nil

      user ->
        user
    end
  end

  def create_user(params) do
    changeset = User.changeset(%User{}, params)
    Repo.insert(changeset)
  end
end
