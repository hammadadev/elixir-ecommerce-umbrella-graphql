defmodule EcommerceWeb.Graphql.Schema.Resolvers.UserResolver do
  alias Ecommerce.Users.Users

  def find_user(_parent, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def create_user(_, %{input: params}, _) do
    Users.create_user(params)
  end

  def user_login(_, %{input: params}, _) do
    Users.user_login(params)
  end
end
