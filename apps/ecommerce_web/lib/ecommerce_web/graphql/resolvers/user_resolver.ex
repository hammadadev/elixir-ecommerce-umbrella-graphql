defmodule EcommerceWeb.Graphql.Schema.Resolvers.UserResolver do
  alias Ecommerce.Users.Users

  def find_user(_parent, %{id: id}, _resolution) do
    case Users.find_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}

      user ->
        {:ok, user}
    end
  end

  def create_user(_, %{input: params}, _) do
    case Users.create_user(params) do
      {:error, _changeset} ->
        {:error, "Error"}

      {:ok, user} ->
        {:ok, user}
    end
  end
end
