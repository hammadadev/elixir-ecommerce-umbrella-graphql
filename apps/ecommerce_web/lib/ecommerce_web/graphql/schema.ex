defmodule EcommerceWeb.Graphql.Schema do
  use Absinthe.Schema
  alias EcommerceWeb.Graphql.Schema
  alias Schema.Middleware.{ChangesetErrors, Authorize}
  import_types(Schema.Types.UserTypes)

  def middleware(middleware, field, %{identifier: :mutation}) do
    # middleware Authorize, field.identifier

    [{Authorize, field.identifier}] ++ middleware ++ [ChangesetErrors]
  end

  def middleware(middleware, _field, _object), do: [Authorize] ++ middleware

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
