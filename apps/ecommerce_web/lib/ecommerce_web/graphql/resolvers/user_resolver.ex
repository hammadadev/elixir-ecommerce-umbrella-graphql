defmodule EcommerceWeb.Graphql.Schema.Resolvers.UserResolver do
  alias Ecommerce.Users.Users
  # TODO: Remove id params and get current user from token.
  def find_user(_parent, %{id: id}, _resolution), do: Users.find_user(id)

  def create_user(_, %{input: params}, _) do
    Users.create_user(params)
  end

  def user_login(_, %{input: params}, _) do
    Users.user_login(params)
  end
end
