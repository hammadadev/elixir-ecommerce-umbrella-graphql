defmodule EcommerceWeb.Graphql.Schema.Middleware.Unauthorize do
  @behaviour Absinthe.Middleware
  def call(res, _) do
    case res.value do
      %{token: _token, user: user} ->
        Map.update!(res, :context, &Map.put(&1, :current_user, user))

      _ ->
        res
    end
  end
end
