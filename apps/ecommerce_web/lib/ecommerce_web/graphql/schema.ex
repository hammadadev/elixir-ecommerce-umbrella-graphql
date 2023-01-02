defmodule EcommerceWeb.Graphql.Schema do
  use Absinthe.Schema
  alias EcommerceWeb.Graphql.Schema
  import_types(Schema.Types.UserTypes)

  query do
    import_fields(:user_queries)
  end
end
