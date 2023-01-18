defmodule EcommerceWeb.Graphql.Schema.Types.UserTypes do
  use Absinthe.Schema.Notation
  alias EcommerceWeb.Graphql.Schema.Resolvers.UserResolver
  alias EcommerceWeb.Graphql.Schema.Middleware.Unauthorize

  @desc "A user of the system"
  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:telephone, :string)
  end

  object :login_details do
    field(:token, :string)
    field(:user, :user)
  end

  input_object :user_input do
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:first_name, non_null(:string))
    field(:password, non_null(:string))
    field(:last_name, :string)
    field(:telephone, :string)
  end

  input_object :login_input do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end

  object :user_queries do
    @desc "Get current user"
    field :user, :user do
      resolve(&UserResolver.find_user/3)
    end
  end

  object :user_mutations do
    @desc "Create a user"
    field :create_user, :login_details do
      arg(:input, non_null(:user_input))
      resolve(&UserResolver.create_user/3)
      middleware(Unauthorize)
    end

    @desc "Return a user and token"
    field :login, :login_details do
      arg(:input, non_null(:login_input))
      resolve(&UserResolver.user_login/3)
      middleware(Unauthorize)
    end
  end
end
