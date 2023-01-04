defmodule EcommerceWeb.Graphql.Schema.Types.UserTypes do
  use Absinthe.Schema.Notation
  alias EcommerceWeb.Graphql.Schema.Resolvers.UserResolver

  @desc "A user of the system"
  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:telephone, :string)
  end

  input_object :user_input do
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:first_name, non_null(:string))
    field(:password, non_null(:string))
    field(:last_name, :string)
    field(:telephone, :string)
  end

  object :user_queries do
    @desc "Get user of the system"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&UserResolver.find_user/3)
    end
  end

  object :user_mutations do
    @desc "Create a user"
    field :create_user, :user do
      arg(:input, non_null(:user_input))
      resolve(&UserResolver.create_user/3)
    end
  end
end
