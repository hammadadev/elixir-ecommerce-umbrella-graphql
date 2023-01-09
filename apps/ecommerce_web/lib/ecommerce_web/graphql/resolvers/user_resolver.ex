defmodule EcommerceWeb.Graphql.Schema.Resolvers.UserResolver do
  alias Ecommerce.Users.Users
  alias EcommerceWeb.Graphql.Errors

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
      {:error, changeset} ->
        {
          :error,
          message: "Errors creating user", details: Errors.error_details(changeset)
        }

      {:ok, data} ->
        {:ok, data}
    end
  end

  def validate_user(_, %{input: params}, _) do
    Users.validate_user(params)
  end
end
