defmodule EcommerceWeb.Graphql.Schema.Types.UserTypes do
  use Absinthe.Schema.Notation
  alias EcommerceWeb.Graphql.Schema.Resolvers.UserResolver

  @desc "A user of the system"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:username, :string)
    field(:first_name, :string)
  end

  object :user_queries do
    @desc "Get user of the system"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&UserResolver.find_user/3)
    end
  end
end
